# MPSTATS Development Patterns

## Integration Patterns

### Pattern: Fetch subject stats with retry

```typescript
async function fetchSubjectStats(
  subjectId: number,
  dateRange: { d1: string; d2: string },
  apiKey: string,
  retries = 3
): Promise<SubjectStats> {
  const url = new URL(`https://mpstats.io/api/v1/wb/get/subject/${subjectId}`);
  url.searchParams.set('d1', dateRange.d1);
  url.searchParams.set('d2', dateRange.d2);

  for (let attempt = 0; attempt < retries; attempt++) {
    try {
      const res = await fetch(url.toString(), {
        headers: { 'X-Mpstats-TOKEN': apiKey },
        signal: AbortSignal.timeout(10000),
      });

      if (res.status === 429) {
        // Rate limit — wait and retry
        await new Promise(r => setTimeout(r, 2000 * (attempt + 1)));
        continue;
      }

      if (!res.ok) throw new Error(`HTTP ${res.status}`);
      return res.json();
    } catch (err) {
      if (attempt === retries - 1) throw err;
      await new Promise(r => setTimeout(r, 1000 * (attempt + 1)));
    }
  }
  throw new Error('Max retries exceeded');
}
```

### Pattern: Batch subjects query with ClickHouse

```python
import httpx
import json
from typing import Optional

def query_wbsubjectsstats(
    filters: dict,
    limit: int = 20,
    ch_host: str = "10.1.1.67",
    ch_user: str = "chatbot",
    ch_password: str = "",
) -> list[dict]:
    """
    Query wbsubjectsstats with dynamic filters.
    
    filters example:
    {
        "revenue_min": 1000000,
        "revenue_max": 10000000,
        "is_seasonal": False,
        "max_oversized_share": 0.3,
        "max_monopoly_score": 0.5,
        "subject_ids": [1, 2, 3],  # optional whitelist
    }
    """
    conditions = ["1=1"]
    
    if "revenue_min" in filters:
        conditions.append(f"revenue >= {filters['revenue_min']}")
    if "revenue_max" in filters:
        conditions.append(f"revenue <= {filters['revenue_max']}")
    if filters.get("is_seasonal") is False:
        conditions.append("is_seasonal = 0")
    if "max_oversized_share" in filters:
        conditions.append(f"oversized_share <= {filters['max_oversized_share']}")
    if "max_monopoly_score" in filters:
        conditions.append(f"monopoly_score <= {filters['max_monopoly_score']}")
    if "subject_ids" in filters and filters["subject_ids"]:
        ids = ",".join(str(i) for i in filters["subject_ids"])
        conditions.append(f"subjectId IN ({ids})")
    
    sql = f"""
        SELECT
            subjectId,
            subjectName,
            groupname,
            revenue,
            revenue_median,
            orders,
            items_count,
            sellers_count,
            avg_price,
            monopoly_score,
            oversized_share,
            is_seasonal
        FROM wbsubjectsstats
        WHERE {' AND '.join(conditions)}
        ORDER BY revenue DESC
        LIMIT {limit}
    """
    
    resp = httpx.post(
        f"http://{ch_host}:8123/",
        params={
            "user": ch_user,
            "password": ch_password,
            "default_format": "JSONEachRow",
        },
        content=sql,
        timeout=30.0,
    )
    resp.raise_for_status()
    
    return [
        json.loads(line)
        for line in resp.text.strip().splitlines()
        if line
    ]
```

### Pattern: Natural language → SQL with LLM

```python
from openai import OpenAI  # or use httpx directly with OpenRouter

SCHEMA_DESCRIPTION = """
Table: wbsubjectsstats
Key columns for filtering:
- revenue (Float64): total revenue RUB last 30 days
- revenue_median (Float64): median seller revenue
- revenue_per_item (Float64): avg revenue per SKU  
- orders (Int64): total orders last 30 days
- items_count (Int32): active SKU count
- sellers_count (Int32): seller count
- avg_price (Float64): average price RUB
- monopoly_score (Float64): 0=competitive, 1=monopoly
- oversized_share (Float64): 0-1, fraction of oversized items
- is_seasonal (UInt8): 1=seasonal, 0=year-round
- seasonality_coeff (Float64): seasonal coefficient
"""

def query_to_sql(user_query: str, client: OpenAI) -> str:
    response = client.chat.completions.create(
        model="deepseek/deepseek-chat",  # via OpenRouter
        response_format={"type": "json_object"},
        messages=[
            {
                "role": "system",
                "content": f"""Convert user niche search criteria to ClickHouse SQL.
                
{SCHEMA_DESCRIPTION}

Return JSON: {{"sql": "SELECT ... FROM wbsubjectsstats WHERE ... ORDER BY ... LIMIT 10"}}

Rules:
- Budget N RUB → revenue BETWEEN N*1.75 AND N*5
- "not oversized" → oversized_share < 0.2  
- "all-season" → is_seasonal = 0
- "low competition" → monopoly_score < 0.4
- Always include: subjectId, subjectName, groupname, revenue, sellers_count, avg_price
- Always add LIMIT 10 (or user's specified limit)"""
            },
            {"role": "user", "content": user_query}
        ]
    )
    
    result = json.loads(response.choices[0].message.content)
    return result["sql"]
```

### Pattern: Subject name → subjectId mapping

```python
def resolve_subject_by_name(
    name: str,
    ch_host: str,
    ch_user: str, 
    ch_password: str,
    limit: int = 10
) -> list[dict]:
    """Find subjects matching a name (fuzzy search)."""
    # Escape single quotes
    safe_name = name.replace("'", "''")
    
    sql = f"""
        SELECT subjectId, subjectName, groupname, revenue
        FROM wbsubjectsstats
        WHERE subjectName ILIKE '%{safe_name}%'
           OR groupname ILIKE '%{safe_name}%'
        ORDER BY revenue DESC
        LIMIT {limit}
    """
    
    return clickhouse_query(sql, ch_host, ch_user, ch_password)
```

### Pattern: Progressive filter relaxation

```python
def search_with_relaxation(
    base_filters: dict,
    relaxation_steps: list[dict],
    max_iterations: int = 3,
) -> tuple[list[dict], dict]:
    """
    Try query with base filters, relax if no results.
    Returns (results, applied_filters).
    """
    current_filters = base_filters.copy()
    
    for i in range(max_iterations):
        results = query_wbsubjectsstats(current_filters, limit=10)
        
        if results:
            return results, current_filters
        
        # Apply next relaxation step
        if i < len(relaxation_steps):
            step = relaxation_steps[i]
            for key, value in step.items():
                current_filters[key] = value
    
    return [], current_filters


# Usage
results, final_filters = search_with_relaxation(
    base_filters={
        "revenue_min": 1_750_000,
        "revenue_max": 5_000_000,
        "is_seasonal": False,
        "max_oversized_share": 0.2,
        "max_monopoly_score": 0.5,
    },
    relaxation_steps=[
        # Step 1: widen revenue range
        {"revenue_min": 500_000, "revenue_max": 10_000_000},
        # Step 2: remove competition filter
        {"max_monopoly_score": 1.0},
        # Step 3: allow oversized
        {"max_oversized_share": 1.0},
    ]
)
```

## Next.js Integration

### App Router API route for niche search

```typescript
// app/api/niche-search/route.ts
import { NextRequest, NextResponse } from 'next/server';

export async function POST(req: NextRequest) {
  const body = await req.json();
  const { query } = body;

  if (!query) {
    return NextResponse.json({ error: 'Query required' }, { status: 400 });
  }

  // Call nicheExpert service
  const response = await fetch(`${process.env.NICHE_EXPERT_URL}/api/v1/nicheExpert`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
      intent: 'search_niches',
      params: { query, limit: 10 },
    }),
  });

  if (!response.ok) {
    return NextResponse.json({ error: 'Niche search failed' }, { status: 500 });
  }

  const data = await response.json();
  return NextResponse.json(data);
}
```

### React hook for MPSTATS data

```typescript
import { useState, useCallback } from 'react';

interface SubjectResult {
  subjectId: number;
  name: string;
  groupname: string;
  revenue: number;
  sellersCount: number;
  avgPrice: number;
  mpstatsUrl: string;
}

export function useNicheSearch() {
  const [results, setResults] = useState<SubjectResult[]>([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const search = useCallback(async (query: string) => {
    setLoading(true);
    setError(null);

    try {
      const res = await fetch('/api/niche-search', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ query }),
      });

      if (!res.ok) throw new Error('Search failed');

      const data = await res.json();
      setResults(data.data?.subjects ?? []);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Unknown error');
    } finally {
      setLoading(false);
    }
  }, []);

  return { search, results, loading, error };
}
```

## Testing Patterns

### Mock ClickHouse in tests

```python
import pytest
from unittest.mock import patch, MagicMock

@pytest.fixture
def mock_clickhouse():
    sample_data = [
        {
            "subjectId": 105,
            "subjectName": "Кроссовки мужские",
            "groupname": "Обувь",
            "revenue": 45000000,
            "sellers_count": 120,
            "avg_price": 3800,
            "monopoly_score": 0.3,
            "oversized_share": 0.0,
        }
    ]
    
    with patch("your_module.clickhouse_query", return_value=sample_data) as mock:
        yield mock


def test_niche_search(mock_clickhouse):
    result = search_niches("кроссовки бюджет 300к")
    assert len(result) > 0
    assert result[0]["subjectName"] == "Кроссовки мужские"
```

### Mock MPSTATS API in tests

```typescript
// __tests__/mpstats.test.ts
import { vi } from 'vitest';

vi.mock('~/lib/mpstats-client', () => ({
  MpstatsClient: vi.fn().mockImplementation(() => ({
    getSubjectStats: vi.fn().mockResolvedValue({
      id: 105,
      name: 'Кроссовки мужские',
      revenue: 45000000,
      orders: 12000,
    }),
  })),
}));
```

## Environment Setup Checklist

```bash
# .env.local or .env
MPSTATS_API_KEY=                 # from mpstats.io/profile/api
NICHE_EXPERT_URL=                # internal URL (requires VPN)
CLICKHOUSE_HOST=                 # 10.1.1.67 or 10.1.1.197
CLICKHOUSE_USER=                 # chatbot or ai_assistant_admin
CLICKHOUSE_PASSWORD=             # from credentials
OPENROUTER_API_KEY=              # for LLM calls
ZEP_API_URL=                     # http://135.181.77.44:8000
```

Note: ClickHouse hosts (10.1.1.x) are only accessible from within the MPSTATS corporate network. Use SSH tunnel for remote development:

```bash
ssh -L 8123:10.1.1.67:8123 your-mpstats-server
```

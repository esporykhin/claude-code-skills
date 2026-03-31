---
name: mpstats
description: MPSTATS marketplace analytics platform. Use when building integrations with MPSTATS API, working with Wildberries or Ozon analytics data, developing AI assistants for marketplace sellers, querying ClickHouse for WB/Ozon subject stats, building niche search or product analysis features. Triggers: "mpstats", "wildberries analytics", "ozon analytics", "WB нишa", "маркетплейс аналитика", "niche search wb", "mpstats api".
---

# MPSTATS — Marketplace Analytics Platform

MPSTATS (mpstats.io) is the leading analytics platform for Russian marketplaces: Wildberries (WB) and Ozon. It provides sales data, competitor analysis, niche research, keyword analytics, and AI-powered tools for marketplace sellers.

## Additional Reference Files

- [API Reference](api-reference.md) — REST API endpoints, authentication, rate limits, response formats
- [Data Models](data-models.md) — ClickHouse table schemas, key fields, SQL patterns
- [AI Assistants](ai-assistants.md) — Architecture of MPSTATS AI chatbots (niche search WB/Ozon)
- [Development Patterns](dev-patterns.md) — Code patterns, integration examples, common tasks

## Platform Overview

### Core Products

| Product | Description |
|---------|-------------|
| WB Analytics | Sales data, revenue estimates, category trends for Wildberries |
| Ozon Analytics | Same for Ozon marketplace |
| Niche Search | AI-powered tool to find profitable product niches (subjects) |
| Keyword Analytics | Search volume, keyword positions, SEO for WB/Ozon |
| Competitor Analysis | Track competitor products, pricing, sales |
| AI Copilot | In-product AI assistant for marketplace sellers |

### Key Concepts

**Subject (Niша / Ниша)** — A product category on Wildberries. WB uses a tree of subjects (~7,000 leaves) to classify products. `subjectId` is the primary key. Example: "Кроссовки мужские" (subjectId: 105).

**SKU / nmId** — Wildberries product ID (артикул WB). Every product has a unique `nmId`.

**Seller / Продавец** — Marketplace merchant identified by `sellerId`.

**Subject Stats** — Aggregate metrics per subject: revenue, orders, price range, competition level, etc.

### MPSTATS URLs

- App: `https://mpstats.io`
- WB Subject page: `https://mpstats.io/wb/subject?id={subjectId}`
- WB Product page: `https://mpstats.io/wb/item/{nmId}`
- API: `https://mpstats.io/api/v1/`
- Docs: `https://mpstats.io/api-docs`

## Quick Start: MPSTATS REST API

### Authentication

All API requests require a Bearer token in the `X-Mpstats-TOKEN` header:

```typescript
const headers = {
  'X-Mpstats-TOKEN': process.env.MPSTATS_API_KEY,
  'Content-Type': 'application/json',
};
```

### Base URL

```
https://mpstats.io/api/v1/
```

### Key Endpoints

```typescript
// Get subject (niche) statistics
GET /wb/get/subject/{subject}
  ?d1=2024-01-01     // start date
  &d2=2024-01-31     // end date
  
// Search subjects by keyword
GET /wb/get/keyword/subjects
  ?keyword=кроссовки
  
// Get item (product) data
GET /wb/get/item/{nmId}
  ?d1=2024-01-01
  &d2=2024-01-31

// Get seller products
GET /wb/get/seller/{sellerId}
  ?d1=2024-01-01
  &d2=2024-01-31

// Search keywords for a subject
GET /wb/get/keywords
  ?subject_id=105
  &d1=2024-01-01
  &d2=2024-01-31
```

### TypeScript API Client Example

```typescript
interface MpstatsConfig {
  apiKey: string;
  baseUrl?: string;
}

interface SubjectStats {
  id: number;
  name: string;
  groupname: string;
  revenue: number;
  revenue_median: number;
  orders: number;
  items_count: number;
  avg_price: number;
  brands_count: number;
  sellers_count: number;
}

class MpstatsClient {
  private baseUrl: string;
  private headers: Record<string, string>;

  constructor({ apiKey, baseUrl = 'https://mpstats.io/api/v1' }: MpstatsConfig) {
    this.baseUrl = baseUrl;
    this.headers = {
      'X-Mpstats-TOKEN': apiKey,
      'Content-Type': 'application/json',
    };
  }

  async getSubjectStats(subjectId: number, d1: string, d2: string): Promise<SubjectStats> {
    const url = `${this.baseUrl}/wb/get/subject/${subjectId}?d1=${d1}&d2=${d2}`;
    const res = await fetch(url, { headers: this.headers });
    if (!res.ok) throw new Error(`MPSTATS API error: ${res.status} ${res.statusText}`);
    return res.json();
  }

  async searchSubjects(keyword: string): Promise<SubjectStats[]> {
    const url = `${this.baseUrl}/wb/get/keyword/subjects?keyword=${encodeURIComponent(keyword)}`;
    const res = await fetch(url, { headers: this.headers });
    if (!res.ok) throw new Error(`MPSTATS API error: ${res.status} ${res.statusText}`);
    return res.json();
  }
}
```

### Python API Client Example

```python
import httpx
from dataclasses import dataclass

@dataclass
class SubjectStats:
    id: int
    name: str
    revenue: float
    orders: int
    items_count: int

class MpstatsClient:
    def __init__(self, api_key: str, base_url: str = "https://mpstats.io/api/v1"):
        self.base_url = base_url
        self.client = httpx.Client(
            headers={"X-Mpstats-TOKEN": api_key},
            timeout=30.0
        )

    def get_subject_stats(self, subject_id: int, d1: str, d2: str) -> dict:
        resp = self.client.get(
            f"{self.base_url}/wb/get/subject/{subject_id}",
            params={"d1": d1, "d2": d2}
        )
        resp.raise_for_status()
        return resp.json()

    def search_keywords(self, keyword: str) -> list[dict]:
        resp = self.client.get(
            f"{self.base_url}/wb/get/keyword/subjects",
            params={"keyword": keyword}
        )
        resp.raise_for_status()
        return resp.json()
```

## ClickHouse Data Warehouse

MPSTATS stores aggregated analytics in ClickHouse. Key tables:

### wbsubjectsstats — WB Subject Aggregates (30-day window)

Primary table for niche search. ~7,000 rows, one per WB subject. Updated daily.

```sql
-- Key fields
SELECT
    subjectId,          -- INT: subject identifier
    subjectName,        -- STRING: subject display name
    groupname,          -- STRING: parent category
    
    -- Revenue metrics
    revenue,            -- FLOAT: total revenue (RUB) last 30 days
    revenue_median,     -- FLOAT: median seller revenue
    revenue_per_item,   -- FLOAT: avg revenue per SKU
    
    -- Volume metrics
    orders,             -- INT: total orders last 30 days
    orders_per_item,    -- FLOAT: avg orders per SKU
    
    -- Market structure
    items_count,        -- INT: total active SKUs
    brands_count,       -- INT: number of brands
    sellers_count,      -- INT: number of sellers
    
    -- Price metrics
    avg_price,          -- FLOAT: average price (RUB)
    price_range_low,    -- FLOAT: 10th percentile price
    price_range_high,   -- FLOAT: 90th percentile price
    
    -- Competition metrics
    top_item_share,     -- FLOAT: revenue share of top 1 item (0-1)
    top10_share,        -- FLOAT: revenue share of top 10 items
    monopoly_score,     -- FLOAT: competition level (lower = more competition)
    
    -- Seasonality
    seasonality_coeff,  -- FLOAT: seasonal demand coefficient
    is_seasonal,        -- BOOL: has strong seasonality
    
    -- Logistics
    avg_weight_kg,      -- FLOAT: average product weight
    oversized_share     -- FLOAT: share of oversized items (0-1)
FROM wbsubjectsstats
```

### Common SQL Patterns for Niche Search

```sql
-- Find niches with budget ~500k RUB, low competition, not oversized
SELECT
    subjectId,
    subjectName,
    groupname,
    revenue,
    revenue_median,
    items_count,
    sellers_count,
    monopoly_score,
    avg_price,
    oversized_share
FROM wbsubjectsstats
WHERE
    revenue BETWEEN 1750000 AND 5000000   -- budget → revenue proxy (3.5x)
    AND oversized_share < 0.2              -- not oversized
    AND is_seasonal = 0                    -- all-season
    AND monopoly_score < 0.5               -- competitive market
ORDER BY revenue DESC
LIMIT 10;

-- Find niches in a specific price range
SELECT subjectId, subjectName, revenue, avg_price, sellers_count
FROM wbsubjectsstats
WHERE avg_price BETWEEN 500 AND 2000
    AND revenue > 500000
ORDER BY revenue / items_count DESC;  -- best revenue per SKU
```

## AI Assistant Architecture (nicheExpert)

MPSTATS has an AI-powered niche search assistant. Key architectural decisions:

### Intent-Based API

The assistant uses typed intents instead of free-form queries:

```python
# POST /api/v1/nicheExpert
{
    "intent": "search_niches",
    "params": {
        "query": "budget 500k, all-season, not oversized",
        "limit": 10
    }
}
```

Available intents:
- `search_niches` — find WB subjects matching criteria
- `search_items` — find specific products
- `analyze` — deep analysis of a subject
- `seasonality` — seasonal demand analysis
- `competition` — competitive landscape
- `trends` — market trends over time

### Response Format

```python
{
    "success": True,
    "data": {
        "subjects": [...],
        "totalFound": 47,
        "filtersRelaxed": False,
        "assumptions": ["Budget 500k converted to revenue 1.75-5M"],
        "sqlQuery": "SELECT ..."
    },
    "meta": {
        "intent": "search_niches",
        "durationMs": 4200,
        "llmCalls": 5,
        "llmCostEstimate": 0.031
    }
}
```

### NLP Pipeline for niche search (6 steps)

1. **Category Detection** — does query mention a specific category? (deepseek-chat, JSON output)
2. **Subject Resolution** — map category name to subjectIds via Zep Vector Store + ILIKE
3. **Criteria Analysis** — extract filters from natural language (budget, seasonality, size, etc.)
4. **SQL Generation** — convert criteria to ClickHouse SQL
5. **Execution** — run query, check results
6. **Filter Relaxation** — if 0 results, progressively loosen constraints

## Development Setup for MPSTATS Projects

### Environment Variables

```bash
# API access
MPSTATS_API_KEY=your_token_here

# Internal ClickHouse (MPSTATS network only)
CLICKHOUSE_HOST=10.1.1.67
CLICKHOUSE_PORT=8123
CLICKHOUSE_USER=chatbot
CLICKHOUSE_DB=default

# New AI cluster (requires VPN/SSH tunnel)
CLICKHOUSE_AI_HOST=10.1.1.197

# OpenRouter for LLM calls
OPENROUTER_API_KEY=your_key_here

# Zep Vector Store (subject embeddings)
ZEP_API_URL=http://135.181.77.44:8000
```

### Tech Stack

MPSTATS internal projects use:
- **Backend**: Python (FastAPI) or Node.js (Next.js API routes)
- **Database**: ClickHouse (analytics), PostgreSQL (transactional)
- **Queue**: BullMQ (Node.js) or Celery (Python)
- **LLM**: OpenRouter (deepseek-chat for cheap steps, gpt-4.1 for critical steps)
- **Vector Store**: Zep (subject embeddings for semantic search)
- **Infra**: Docker, internal Kubernetes

### ClickHouse Connection (Python)

```python
import httpx

def clickhouse_query(sql: str, host: str, user: str, password: str) -> list[dict]:
    """Execute ClickHouse query via HTTP interface."""
    resp = httpx.post(
        f"http://{host}:8123/",
        params={"user": user, "password": password, "default_format": "JSONEachRow"},
        content=sql,
        timeout=30.0
    )
    resp.raise_for_status()
    return [
        json.loads(line) 
        for line in resp.text.strip().splitlines() 
        if line
    ]
```

### ClickHouse Connection (Node.js)

```typescript
import { createClient } from '@clickhouse/client';

const ch = createClient({
  host: process.env.CLICKHOUSE_HOST,
  username: process.env.CLICKHOUSE_USER,
  password: process.env.CLICKHOUSE_PASSWORD,
  database: 'default',
});

async function querySubjects(sql: string) {
  const result = await ch.query({ query: sql, format: 'JSONEachRow' });
  return result.json();
}
```

## MPSTATS AI Assistant PostgreSQL Schema

The production AI assistant logs all queries to PostgreSQL:

```sql
-- niche_assistant_logs: all search requests
SELECT id, user_request, reformulate_user_request, generated_sql, created_at
FROM niche_assistant_logs
WHERE reformulate_user_request IS NOT NULL  -- real search (not greeting/clarification)
  AND created_at >= NOW() - INTERVAL '30 days';

-- messages: bot + user binding
SELECT id, bot_name, chatid, created_at
FROM messages;
-- bot_name: 'niche_wb_web' (82% traffic) or 'niche_ozon_web' (18%)

-- answers: responses and feedback
SELECT request_id, type, feedback_score, feedback_text, is_client
FROM answers
WHERE feedback_score IS NOT NULL;
-- feedback_score: 'positive' or 'negative'
```

## Common Tasks & Patterns

### Task: Build a feature that reads MPSTATS data

1. Check if you need real-time data (REST API) or batch analytics (ClickHouse)
2. For REST API: use `X-Mpstats-TOKEN` header, see endpoints above
3. For ClickHouse: connect to internal host (requires VPN or SSH tunnel)
4. Always handle rate limits — MPSTATS API has per-minute limits

### Task: Implement niche search

1. Accept user query in natural language
2. Use LLM to extract structured criteria (budget, category, constraints)
3. Convert to SQL for `wbsubjectsstats`
4. If no results: relax filters progressively (raise/lower thresholds by 20-30%)
5. Return with `assumptions[]` array explaining any conversions made

### Task: Add MPSTATS data to an AI assistant

1. Use the `nicheExpert` intent-based API if available
2. Otherwise call REST API directly for specific data
3. Format URLs as `https://mpstats.io/wb/subject?id={id}` for subject links
4. Include revenue, orders, competition metrics in context

### Task: Parse WB category tree

```python
# WB categories have 3 levels: parent → group → subject
# subjectId is always the leaf node
# groupname is the 2nd level (e.g. "Обувь")
# parent is the top level (e.g. "Женщинам")

# Get all unique groups:
SELECT DISTINCT groupname FROM wbsubjectsstats ORDER BY groupname;

# Get subjects in a group:
SELECT subjectId, subjectName FROM wbsubjectsstats 
WHERE groupname = 'Обувь' ORDER BY revenue DESC;
```

## Pitfalls & Notes

- **Budget → Revenue conversion**: User budget of X RUB/month corresponds to niche revenue of ~3.5X (average seller captures 1/3.5 of niche revenue). Use `revenue BETWEEN budget*1.75 AND budget*5` for a safe range.
- **API pagination**: Most list endpoints use `cursor`-based pagination, not page numbers
- **Date format**: Always `YYYY-MM-DD` for `d1`/`d2` parameters
- **Rate limits**: Public API ~60 req/min, internal ClickHouse has no limit but be respectful
- **Data freshness**: ClickHouse stats update daily around 6-8 AM Moscow time (UTC+3)
- **Subject IDs are stable**: WB `subjectId` values don't change, safe to cache
- **nmId vs article**: WB `nmId` is the system ID; sellers have their own "артикул" (SKU) which is different

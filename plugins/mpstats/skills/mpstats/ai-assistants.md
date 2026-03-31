# MPSTATS AI Assistants

## Overview

MPSTATS has two production AI chatbots for marketplace sellers:
- **niche_wb_web** — Wildberries niche search (~82% of traffic)
- **niche_ozon_web** — Ozon niche search (~18% of traffic)

These help sellers find profitable product niches using natural language.

## nicheExpert Service

The `nicheExpert` skill is a stateless FastAPI service that exposes an intent-based API.

### Endpoint

```
POST /api/v1/nicheExpert
```

### Request Format

```json
{
  "intent": "search_niches",
  "params": {
    "query": "бюджет 500к, всесезонные, не крупногабаритные",
    "limit": 10
  }
}
```

### Available Intents

| Intent | Description | Key Params |
|--------|-------------|------------|
| `search_niches` | Find WB subjects matching natural language criteria | `query`, `limit`, `excludeSubjectIds` |
| `search_items` | Find specific products matching criteria | `query`, `limit` |
| `analyze` | Deep analysis of a subject | `subjectId` |
| `seasonality` | Seasonal demand analysis | `subjectId` or `query` |
| `competition` | Competitive landscape for a niche | `subjectId` |
| `trends` | Market trends over time | `subjectId` or `query` |
| `search_queries` | Top search queries for a subject | `subjectId` |
| `mpstats_info` | General MPSTATS platform info | — |

### Response Format

```json
{
  "success": true,
  "data": {
    "subjects": [
      {
        "subjectId": 1234,
        "name": "Кроссовки мужские",
        "groupname": "Обувь",
        "revenue": 45000000,
        "revenue_median": 85000,
        "orders": 12000,
        "items_count": 450,
        "sellers_count": 120,
        "avg_price": 3800,
        "monopoly_score": 0.3,
        "oversized_share": 0.0,
        "mpstatsUrl": "https://mpstats.io/wb/subject?id=1234"
      }
    ],
    "totalFound": 23,
    "filtersRelaxed": false,
    "relaxationDetails": null,
    "assumptions": [
      "Бюджет 500к конвертирован в выручку ниши 1.75-5 млн"
    ],
    "unsolvableCriteria": [],
    "sqlQuery": "SELECT ... LIMIT 10"
  },
  "meta": {
    "intent": "search_niches",
    "durationMs": 3800,
    "llmCalls": 5,
    "llmTokensUsed": { "input": 11000, "output": 2800 },
    "llmCostEstimate": 0.028
  }
}
```

### Error Response

```json
{
  "success": false,
  "error": {
    "code": "query_timeout",
    "message": "ClickHouse query timed out after 30000ms"
  }
}
```

## Search Pipeline (search_niches)

The niche search uses a 6-step LLM pipeline:

### Step 1: Category Detection
- Model: `deepseek-chat` (cheap, fast)
- Input: raw user query
- Output: `{ hasSpecificCategory, include_categories[], exclude_categories[] }`

### Step 2: Subject Resolution
- If category found → lookup subjectIds in Zep Vector Store (semantic search on subject names)
- Fallback: ClickHouse `ILIKE` query on `subjectName`
- Output: list of matching `subjectId`s to filter by

### Step 3: Criteria Analysis
- Model: `deepseek-chat`
- Input: query + available ClickHouse columns
- Output: structured filters:
  ```json
  {
    "budget_rub": 500000,
    "is_seasonal": false,
    "max_oversized_share": 0.2,
    "max_monopoly_score": 0.5,
    "price_range": [500, 3000],
    "sort_by": "revenue",
    "sort_direction": "DESC"
  }
  ```

### Step 4: SQL Generation
- Model: `deepseek-chat`
- Input: criteria JSON + table schema
- Output: ClickHouse SQL query

### Step 5: Execution
- Run SQL against ClickHouse
- Check result count

### Step 6: Filter Relaxation (if 0 results)
- Progressively loosen filters by 20-30%
- Max 3 relaxation iterations
- Record what was changed in `relaxationDetails`

## Agent Architecture

The chatbot agent itself (not the skill) handles:
- **Onboarding**: gathering seller criteria interactively
- **Intent routing**: deciding which intent to call
- **Chain calls**: calling nicheExpert 2-3 times for complex queries
- **Response formatting**: making results readable for sellers

The agent reads `SKILL.md` as system context.

### Multi-turn conversation example

```
User: Хочу начать торговать на WB, бюджет 300к
Agent: → analyze user intent → call search_niches with budget constraint
       → show top 5 results
User: Покажи только в ценовом диапазоне 1000-3000₽
Agent: → refine previous search → call search_niches with price filter added
User: Расскажи подробнее про первую нишу
Agent: → call analyze with subjectId from previous result
```

## Building a Custom Agent on Top of MPSTATS

### System Prompt Template

```python
SYSTEM_PROMPT = """
You are a marketplace analytics assistant for {platform} (Wildberries/Ozon).
You help sellers find profitable niches and analyze market opportunities.

You have access to the nicheExpert tool which can:
- Search niches matching criteria (budget, category, seasonality, competition level)
- Analyze specific niches in depth  
- Research market trends and seasonality

When a user asks about niches or products:
1. Collect key criteria: budget, category preferences, constraints
2. Call nicheExpert with appropriate intent
3. Present results clearly with key metrics
4. Offer to analyze specific niches in more detail

Always include:
- Revenue figures in RUB
- Number of sellers (competition indicator)
- Average price range
- MPSTATS link for each niche

Budget to revenue conversion: user budget X → niche revenue 1.75X to 5X range
"""
```

### Tool Definition (OpenAI-compatible)

```python
NICHE_EXPERT_TOOL = {
    "type": "function",
    "function": {
        "name": "nicheExpert",
        "description": "Search and analyze product niches on Wildberries marketplace",
        "parameters": {
            "type": "object",
            "properties": {
                "intent": {
                    "type": "string",
                    "enum": ["search_niches", "analyze", "seasonality", "competition", "trends"],
                    "description": "Type of analysis to perform"
                },
                "params": {
                    "type": "object",
                    "properties": {
                        "query": {"type": "string", "description": "Natural language search criteria"},
                        "subjectId": {"type": "integer", "description": "WB subject ID for analysis"},
                        "limit": {"type": "integer", "default": 10}
                    }
                }
            },
            "required": ["intent", "params"]
        }
    }
}
```

## Deployment Notes

- nicheExpert runs on port 15001 internally
- Health check: `GET /api/v1/health`
- Stateless — each request is independent
- Typical latency: 3-8 seconds (LLM pipeline)
- ClickHouse queries: < 500ms typically

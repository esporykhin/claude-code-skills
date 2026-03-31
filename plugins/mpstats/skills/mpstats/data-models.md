# MPSTATS Data Models & ClickHouse Schemas

## ClickHouse Architecture

MPSTATS uses ClickHouse for high-performance analytics queries.

Connection: HTTP interface on port 8123
```
POST http://{host}:8123/?user={user}&password={pass}&default_format=JSONEachRow
Body: SQL query
```

## wbsubjectsstats — WB Subject Aggregates

The primary table for niche research. ~7,000 rows, aggregated over 30 days.

```sql
CREATE TABLE wbsubjectsstats (
    -- Identity
    subjectId       Int32,          -- WB subject identifier (stable)
    subjectName     String,         -- Display name (Russian)
    groupname       String,         -- Parent group name
    parentName      String,         -- Top-level category

    -- Revenue
    revenue         Float64,        -- Total revenue, RUB, last 30 days
    revenue_median  Float64,        -- Median seller revenue
    revenue_per_item Float64,       -- Avg revenue per active SKU
    
    -- Orders
    orders          Int64,          -- Total orders, last 30 days
    orders_per_item Float64,        -- Avg orders per SKU
    
    -- Market structure
    items_count     Int32,          -- Active SKUs (had orders)
    brands_count    Int32,          -- Unique brands
    sellers_count   Int32,          -- Unique sellers
    
    -- Pricing
    avg_price       Float64,        -- Average price, RUB
    median_price    Float64,        -- Median price, RUB
    price_range_low Float64,        -- 10th percentile price
    price_range_high Float64,       -- 90th percentile price
    
    -- Competition
    top_item_share  Float64,        -- Revenue share of #1 product (0-1)
    top3_share      Float64,        -- Revenue share of top 3 products
    top10_share     Float64,        -- Revenue share of top 10 products
    monopoly_score  Float64,        -- Competition index (lower = more competitive)
    
    -- Logistics
    avg_weight_kg   Float64,        -- Average product weight
    oversized_share Float64,        -- Share of oversized items (0-1)
    
    -- Seasonality
    seasonality_coeff Float64,      -- Seasonal coefficient
    is_seasonal     UInt8,          -- 1 if strongly seasonal
    
    -- Timestamps
    updated_at      DateTime        -- Last update time
)
ENGINE = ReplacingMergeTree(updated_at)
ORDER BY subjectId;
```

### Query Examples

```sql
-- Top niches by revenue efficiency (low competition, high revenue/SKU)
SELECT
    subjectId,
    subjectName,
    groupname,
    revenue,
    revenue_per_item,
    sellers_count,
    monopoly_score,
    avg_price
FROM wbsubjectsstats
WHERE revenue > 1000000
  AND monopoly_score < 0.4
  AND is_seasonal = 0
ORDER BY revenue_per_item DESC
LIMIT 20;

-- Price range analysis
SELECT
    groupname,
    COUNT(*) as niches,
    AVG(avg_price) as avg_price,
    SUM(revenue) as total_revenue
FROM wbsubjectsstats
GROUP BY groupname
ORDER BY total_revenue DESC;

-- Find growing niches (compare periods)
-- Note: wbsubjectsstats only has current 30-day window
-- For trends, use dm_trend table
```

## dm_items_summary — WB Product Summary

Daily-updated product-level data:

```sql
SELECT
    nm_id,          -- WB product ID
    name,           -- Product name
    brand,          -- Brand name
    subject_id,     -- Category (subject)
    seller_id,      -- Seller ID
    price,          -- Current price
    revenue_30d,    -- Revenue last 30 days
    orders_30d,     -- Orders last 30 days
    rating,         -- Product rating (1-5)
    reviews_count,  -- Number of reviews
    in_stock,       -- Currently in stock
    created_at      -- First seen date
FROM dm_items_summary
WHERE subject_id = 105
  AND revenue_30d > 50000
ORDER BY revenue_30d DESC;
```

## dm_trend — Market Trends

Weekly/monthly aggregates for trend analysis:

```sql
SELECT
    subject_id,
    period_start,   -- Week/month start date
    revenue,        -- Revenue this period
    orders,         -- Orders this period
    items_count,    -- Active SKUs
    avg_price       -- Average price
FROM dm_trend
WHERE subject_id = 105
  AND period_start >= now() - INTERVAL 6 MONTH
ORDER BY period_start;
```

## PostgreSQL: AI Assistant Schema

Production database for the niche search AI assistant:

### niche_assistant_logs

```sql
CREATE TABLE niche_assistant_logs (
    id              BIGSERIAL PRIMARY KEY,
    user_request    TEXT,                   -- Original user message
    reformulate_user_request TEXT,          -- Reformulated search query (NULL for non-search messages)
    generated_sql   TEXT,                   -- Generated ClickHouse SQL
    sql_result      JSONB,                  -- Query results (truncated)
    iteration_number INT DEFAULT 1,         -- Retry count
    function_calls  JSONB,                  -- LLM function calls log
    created_at      TIMESTAMP DEFAULT NOW()
);

-- IMPORTANT: Only real search requests have reformulate_user_request NOT NULL
-- Greetings, clarifications, general questions = NULL
```

### messages

```sql
CREATE TABLE messages (
    id          BIGINT PRIMARY KEY,         -- References niche_assistant_logs.id
    bot_name    VARCHAR(100),               -- 'niche_wb_web' or 'niche_ozon_web'
    chatid      VARCHAR(255),               -- User identifier
    created_at  TIMESTAMP DEFAULT NOW()
);
```

### answers

```sql
CREATE TABLE answers (
    request_id      BIGINT REFERENCES messages(id),
    type            VARCHAR(50),
    feedback_score  VARCHAR(20),            -- 'positive' or 'negative'
    feedback_text   TEXT,                   -- User comment
    is_client       BOOLEAN,                -- Is paying customer
    closing_msg     TEXT,                   -- Assistant's final message
    created_at      TIMESTAMP DEFAULT NOW()
);
```

### Analytics Queries

```sql
-- Daily active users per bot
SELECT
    m.bot_name,
    DATE(n.created_at) as day,
    COUNT(DISTINCT m.chatid) as dau,
    COUNT(*) as requests
FROM niche_assistant_logs n
JOIN messages m ON m.id = n.id
WHERE n.reformulate_user_request IS NOT NULL
  AND n.created_at >= NOW() - INTERVAL '30 days'
GROUP BY m.bot_name, DATE(n.created_at)
ORDER BY day;

-- Feedback stats
SELECT
    m.bot_name,
    a.feedback_score,
    COUNT(*) as cnt,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY m.bot_name), 1) as pct
FROM answers a
JOIN messages m ON m.id = a.request_id
WHERE a.feedback_score IS NOT NULL
  AND a.created_at >= NOW() - INTERVAL '30 days'
GROUP BY m.bot_name, a.feedback_score;
```

## Data Flow

```
WB/Ozon API → MPSTATS Scrapers → ClickHouse → REST API → Clients
                                      ↓
                               AI Assistants
                                      ↓
                               PostgreSQL (logs)
```

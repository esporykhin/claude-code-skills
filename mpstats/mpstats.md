---
description: "MPSTATS marketplace analytics API integration helper. Use when working with MPSTATS API, Wildberries/Ozon/Yandex Market analytics, or any marketplace data integration."
---

# MPSTATS API — Complete Reference

## What is MPSTATS

MPSTATS (mpstats.io) is the leading Russian marketplace analytics platform. It provides real-time and historical data on products, categories, sellers, brands, and search queries across:
- **Wildberries (WB)** — Russia's largest marketplace
- **Ozon** — second largest Russian marketplace
- **Yandex Market (YM)**

The REST API allows developers to integrate MPSTATS data into their own applications, dashboards, and analytics pipelines.

---

## Authentication

### Getting a Token

Generate your API token in account settings at https://mpstats.io/userpanel in the "API Token" block.

The token is automatically regenerated when you change your password or click "Change API token".

### Using the Token

**Method 1 — HTTP Header (recommended):**
```
X-Mpstats-TOKEN: your_token_here
```

**Method 2 — Query parameter:**
```
&auth-token=your_token_here
```

**Example token format:**
```
5a2a5f0e538dd5.6691914852255446e23a9bcac46ee5255625f5d5
```

---

## Base URL

All API endpoints use this base URL:
```
https://mpstats.io/api/
```

Full endpoint URL format: `https://mpstats.io/api/{endpoint}`

---

## HTTP Response Codes

| Code | Description |
|------|-------------|
| 200 | Successful request |
| 202 | Request accepted for processing but not completed. Retry later. |
| 401 | Authorization error |
| 429 | Rate limit exceeded. Check `message` field for details. `Retry-After` header indicates seconds until retry. |
| 500 | Internal server error. Check `message` field for details. |

---

## Pagination, Sorting, and Filtering

POST endpoints that return lists of products use a standard request body:

```json
{
  "startRow": 0,
  "endRow": 100,
  "filterModel": {},
  "sortModel": [{"colId": "revenue", "sort": "desc"}]
}
```

**Notes:**
- Maximum 5000 records per request
- `startRow` and `endRow` define the pagination window
- `filterModel` supports number and text filters
- `sortModel` accepts any field name with `"asc"` or `"desc"`

**Response structure:**
```json
{
  "startRow": 0,
  "endRow": 100,
  "filterModel": {},
  "sortModel": [],
  "total": 42,
  "data": [...]
}
```

---

## Common Query Parameters

| Parameter | Type | Required | Description | Default |
|-----------|------|----------|-------------|---------|
| `d1` | YYYY-MM-DD | No | Start date of period. For Basic/Extended plans fixed by tariff. | Depends on tariff |
| `d2` | YYYY-MM-DD | No | End date of period. For Basic/Extended plans fixed by tariff. | Depends on tariff |
| `fbs` | `=1` or `=0` | No | Include FBS (Fulfillment by Seller) data | Excluded by default |
| `path` | string | Yes (most) | Category path, brand name, seller name, or SKU ID | — |

---

## Wildberries API

### Catalog — Get All Categories

**GET `wb/get/categories`**

Returns the full WB category tree.

```bash
curl --location --request GET 'https://mpstats.io/api/wb/get/categories' \
  --header 'X-Mpstats-TOKEN: YOUR_TOKEN' \
  --header 'Content-Type: application/json'
```

**Response:**
```json
[
  {
    "url": "/catalog/zhenshchinam/odezhda/svitshoty",
    "name": "Свитшоты",
    "path": "Женщинам/Одежда/Свитшоты"
  }
]
```

| Field | Type | Description |
|-------|------|-------------|
| `url` | text | WB catalog URL |
| `name` | text | Category name |
| `path` | text | Full path in WB catalog hierarchy |

---

### Category — Products

**POST `wb/get/category`**

Get products in a category with sales analytics.

**Query parameters:** `d1`, `d2`, `path` (required), `fbs`

**Request body:** standard pagination/sort/filter object

```bash
curl --location --request POST 'https://mpstats.io/api/wb/get/category?d1=2023-10-01&d2=2023-10-31&path=%D0%96%D0%B5%D0%BD%D1%89%D0%B8%D0%BD%D0%B0%D0%BC/%D0%9E%D0%B4%D0%B5%D0%B6%D0%B4%D0%B0' \
  --header 'X-Mpstats-TOKEN: YOUR_TOKEN' \
  --header 'Content-Type: application/json' \
  --data-raw '{"startRow":0,"endRow":100,"filterModel":{},"sortModel":[{"colId":"revenue","sort":"desc"}]}'
```

**Product fields:**

| Field | Type | Description |
|-------|------|-------------|
| `id` | number | WB product ID (SKU) |
| `name` | text | Product name |
| `brand` | text | Brand name |
| `seller` | text | Seller name |
| `supplier_id` | number | Seller ID |
| `color` | text | Product color |
| `balance` | number | Last recorded stock quantity |
| `balance_fbs` | number | Stock on FBS warehouses |
| `comments` | number | Number of reviews |
| `rating` | number | Product rating |
| `final_price` | number | Last recorded price |
| `final_price_max` | number | Maximum price for the period |
| `final_price_min` | number | Minimum price for the period |
| `final_price_average` | number | Average price (revenue / sales count) |
| `final_price_median` | number | Median price |
| `basic_sale` | number | Discount size, % |
| `basic_price` | number | Base price before discount |
| `promo_sale` | number | Promo code discount, % |
| `client_sale` | number | Loyal customer discount (СПП), % |
| `client_price` | number | Final price with СПП |
| `start_price` | number | Original price |
| `sales` | number | Number of sales in period |
| `sales_per_day_average` | number | Average daily sales |
| `revenue` | number | Revenue in period (RUB) |
| `revenue_potential` | number | Potential revenue (revenue / days in stock * days in report) |
| `revenue_average` | number | Average daily revenue |
| `lost_profit` | number | Lost revenue (out-of-stock periods) |
| `lost_profit_percent` | number | Lost revenue, % |
| `days_in_stock` | number | Days the product was in stock at end of day |
| `days_with_sales` | number | Days with at least one sale |
| `average_if_in_stock` | number | Average daily sales when in stock |
| `is_fbs` | number | 1 = FBS product |
| `subject_id` | number | WB subject (нише) ID |
| `subject` | text | Subject name |
| `purchase` | number | Redemption rate, % |
| `purchase_after_return` | number | Redemption rate after returns, % |
| `country` | text | Country of manufacture |
| `gender` | text | Gender target |
| `sku_first_date` | date | First seen date |
| `firstcommentdate` | date | First review date |
| `picscount` | number | Number of product images |
| `has3d` | number | 1 = has 3D image |
| `hasvideo` | number | 1 = has video |
| `cardratingval` | number | MPStats card quality rating |
| `categories_last_count` | number | Number of categories product appears in |
| `category` | text | Current main category |
| `category_position` | number | Position in main category |
| `product_visibility_graph` | number[] | Keyword visibility graph |
| `category_graph` | number[] | Category count graph |
| `graph` | number[] | Sales graph (daily) |
| `stocks_graph` | number[] | Stock graph (daily) |
| `price_graph` | number[] | Price change graph |
| `thumb` | text | Product thumbnail URL |
| `thumb_middle` | text | Medium product image URL |
| `url` | text | WB product URL |
| `turnover_days` | number | Turnover in days |
| `turnover_once` | number | Turnover rate |

---

### Category — Subcategories

**GET `wb/get/category/subcategories`**

Get subcategory analytics for a parent category.

**Query parameters:** `d1`, `d2`, `path` (required), `fbs`

```bash
curl 'https://mpstats.io/api/wb/get/category/subcategories?d1=2023-10-01&d2=2023-10-31&path=%D0%96%D0%B5%D0%BD%D1%89%D0%B8%D0%BD%D0%B0%D0%BC%2F%D0%9F%D0%BB%D0%B0%D1%82%D1%8C%D1%8F+%D0%B8+%D1%81%D0%B0%D1%80%D0%B0%D1%84%D0%B0%D0%BD%D1%8B&fbs=1' \
  --header 'X-Mpstats-TOKEN: YOUR_TOKEN'
```

**Response fields per subcategory:**

| Field | Type | Description |
|-------|------|-------------|
| `name` | text | Subcategory name |
| `items` | number | Total products |
| `items_with_sells` | number | Products with sales |
| `brands` | number | Number of brands |
| `brands_with_sells` | number | Brands with sales |
| `sellers` | number | Number of sellers |
| `sellers_with_sells` | number | Sellers with sales |
| `sales` | number | Total sales |
| `revenue` | number | Total revenue |
| `avg_price` | number | Average price |
| `comments` | number | Average review count |
| `rating` | number | Average rating |
| `items_with_sells_percent` | number | % products with sales |
| `brands_with_sells_percent` | number | % brands with sales |
| `sellers_with_sells_percent` | number | % sellers with sales |
| `sales_per_items_average` | number | Average sales per product |
| `sales_per_items_with_sells_average` | number | Average sales per product with sales |
| `revenue_per_items_average` | number | Average revenue per product |
| `revenue_per_items_with_sells_average` | number | Average revenue per product with sales |

---

### Category — Brands

**GET `wb/get/category/brands`**

Get brand analytics within a category.

**Query parameters:** `d1`, `d2`, `path` (required), `fbs`

```bash
curl 'https://mpstats.io/api/wb/get/category/brands?d1=2023-10-01&d2=2023-10-31&path=%D0%96%D0%B5%D0%BD%D1%89%D0%B8%D0%BD%D0%B0%D0%BC%2F%D0%9F%D0%BB%D0%B0%D1%82%D1%8C%D1%8F+%D0%B8+%D1%81%D0%B0%D1%80%D0%B0%D1%84%D0%B0%D0%BD%D1%8B&fbs=1' \
  --header 'X-Mpstats-TOKEN: YOUR_TOKEN'
```

| Field | Type | Description |
|-------|------|-------------|
| `brand` | text | Brand name |
| `items` | number | Total products |
| `items_with_sells` | number | Products with sales |
| `items_with_sells_percent` | number | % products with sales |
| `sellers` | number | Number of sellers |
| `sellers_with_sells` | number | Sellers with sales |
| `sales` | number | Total sales |
| `revenue` | number | Total revenue |
| `balance` | number | End-of-period stock |
| `avg_price` | number | Average price |
| `rating` | number | Average rating |
| `comments` | number | Average review count |
| `position` | number | Brand ranking in category (by revenue) |
| `graph` | number[] | Daily sales graph |

---

### Category — Sellers

**GET `wb/get/category/sellers`** *(Professional plan required)*

Get seller analytics within a category.

**Query parameters:** `d1`, `d2`, `path` (required), `fbs`

```bash
curl 'https://mpstats.io/api/wb/get/category/sellers?d1=2023-10-01&d2=2023-10-31&path=%D0%96%D0%B5%D0%BD%D1%89%D0%B8%D0%BD%D0%B0%D0%BC%2F%D0%9F%D0%BB%D0%B0%D1%82%D1%8C%D1%8F+%D0%B8+%D1%81%D0%B0%D1%80%D0%B0%D1%84%D0%B0%D0%BD%D1%8B&fbs=1' \
  --header 'X-Mpstats-TOKEN: YOUR_TOKEN'
```

| Field | Type | Description |
|-------|------|-------------|
| `supplierid` | number | Seller ID |
| `name` | text | Seller name |
| `items` | number | Total products |
| `brands` | number | Number of brands |
| `sales` | number | Total sales |
| `revenue` | number | Total revenue |
| `balance` | number | End-of-period stock |
| `avg_price` | number | Average price |
| `position` | number | Seller ranking in category |
| `graph` | number[] | Daily sales graph |

---

### Category — Trend

**GET `wb/get/category/trends`**

Get trend charts for a category.

**Query parameters:** `d1`, `d2`, `path` (required), `fbs`, `view`

`view` options: `itemsInCategory`, `category`

```bash
curl 'https://mpstats.io/api/wb/get/category/trends?view=itemsInCategory&d1=2023-10-01&d2=2023-10-31&path=%D0%96%D0%B5%D0%BD%D1%89%D0%B8%D0%BD%D0%B0%D0%BC/%D0%9E%D0%B4%D0%B5%D0%B6%D0%B4%D0%B0' \
  --header 'X-Mpstats-TOKEN: YOUR_TOKEN'
```

---

### Category — By Day

**GET `wb/get/category/by_date`**

Get category metrics grouped by time period.

**Query parameters:** `d1`, `d2`, `path` (required), `fbs`, `groupBy`

`groupBy` options: `day`, `week`, `month`

```bash
curl 'https://mpstats.io/api/wb/get/category/by_date?groupBy=day&d1=2023-10-01&d2=2023-10-31&path=%D0%96%D0%B5%D0%BD%D1%89%D0%B8%D0%BD%D0%B0%D0%BC%2F%D0%9F%D0%BB%D0%B0%D1%82%D1%8C%D1%8F&fbs=1' \
  --header 'X-Mpstats-TOKEN: YOUR_TOKEN'
```

---

### Category — Price Segmentation

**GET `wb/get/category/price_segmentation`**

Get sales distribution by price segments.

**Query parameters:** `d1`, `d2`, `path` (required), `fbs`, `spp`

```bash
curl 'https://mpstats.io/api/wb/get/category/price_segmentation?d1=2023-10-01&d2=2023-10-31&path=%D0%96%D0%B5%D0%BD%D1%89%D0%B8%D0%BD%D0%B0%D0%BC%2F%D0%9F%D0%BB%D0%B0%D1%82%D1%8C%D1%8F&fbs=1' \
  --header 'X-Mpstats-TOKEN: YOUR_TOKEN'
```

---

### Category — Compare Periods

**POST `wb/get/category/compare`**

Compare two time periods for a category.

**Query parameters:** `path` (required), `fbs`

```bash
curl --location --request POST 'https://mpstats.io/api/wb/get/category/compare?path=%D0%96%D0%B5%D0%BD%D1%89%D0%B8%D0%BD%D0%B0%D0%BC/%D0%9E%D0%B4%D0%B5%D0%B6%D0%B4%D0%B0&fbs=1' \
  --header 'X-Mpstats-TOKEN: YOUR_TOKEN' \
  --header 'Content-Type: application/json' \
  --data-raw '{"periods": [{"d1": "2023-09-01", "d2": "2023-09-30"}, {"d1": "2023-10-01", "d2": "2023-10-31"}]}'
```

---

### Category — Subjects (Предметы)

**GET `wb/get/category/items`**

Get WB subjects (product types) within a category.

**Query parameters:** `d1`, `d2`, `path` (required), `fbs`

---

### Category — AI Forecast

**GET `analytics/v1/wb/category/forecast/daily`**

Daily sales forecast for a category using AI.

**Query parameters:** `path` (required)

```bash
curl 'https://mpstats.io/api/analytics/v1/wb/category/forecast/daily?path=%D0%96%D0%B5%D0%BD%D1%89%D0%B8%D0%BD%D0%B0%D0%BC/%D0%9F%D0%BB%D0%B0%D1%82%D1%8C%D1%8F' \
  --header 'X-Mpstats-TOKEN: YOUR_TOKEN'
```

**GET `analytics/v1/wb/category/forecast/trend`**

Trend forecast for a category.

**Query parameters:** `path` (required), `period` (e.g. `month12`)

---

### Category — Seasonal Effects

**GET `analytics/v1/wb/category/season_effects/annual`**

Annual seasonality, holidays and sales events in %.

**Query parameters:** `path` (required), `period` (`day`, `week`, `month`)

**GET `analytics/v1/wb/category/season_effects/weekly`**

Weekly seasonality chart in %.

**Query parameters:** `path` (required)

---

### Niche (Subject) — List Subjects

**GET `wb/get/subjects/select`**

Get list of all WB subjects (product niches) for selection.

**Query parameters:** `fbs`

```bash
curl 'https://mpstats.io/api/wb/get/subjects/select?fbs=1' \
  --header 'X-Mpstats-TOKEN: YOUR_TOKEN'
```

---

### Niche — Products

**POST `wb/get/subject`**

Get products in a niche (subject). `path` = subject ID (numeric).

**Query parameters:** `d1`, `d2`, `path` (subject ID, required), `fbs`

**Request body:** standard pagination/sort/filter object

```bash
curl --location --request POST 'https://mpstats.io/api/wb/get/subject?d1=2023-10-01&d2=2023-10-31&path=70&fbs=1' \
  --header 'X-Mpstats-TOKEN: YOUR_TOKEN' \
  --header 'Content-Type: application/json' \
  --data-raw '{"startRow":0,"endRow":100,"filterModel":{},"sortModel":[{"colId":"revenue","sort":"desc"}]}'
```

*Response fields are the same as for `wb/get/category`.*

---

### Niche — Categories

**GET `wb/get/subject/categories`**

Get categories where this niche appears.

**Query parameters:** `d1`, `d2`, `path` (subject ID), `includePromo`

---

### Niche — Brands

**GET `wb/get/subject/brands`**

Get brand analytics within a niche.

**Query parameters:** `d1`, `d2`, `path` (subject ID), `fbs`

---

### Niche — Sellers

**GET `wb/get/subject/sellers`**

Get seller analytics within a niche.

**Query parameters:** `d1`, `d2`, `path` (subject ID), `fbs`

---

### Niche — Trend

**GET `wb/get/subject/trends`**

Get trend chart for a niche.

**Query parameters:** `d1`, `d2`, `path` (subject ID)

---

### Niche — By Day

**GET `wb/get/subject/by_date`**

Niche metrics grouped by time period.

**Query parameters:** `d1`, `d2`, `path` (subject ID), `groupBy` (`day`/`week`/`month`)

---

### Niche — Price Segmentation

**GET `wb/get/subject/price_segmentation`**

Price distribution within a niche.

**Query parameters:** `d1`, `d2`, `path` (subject ID), `fbs`, `spp`

---

### Niche — Compare Periods

**POST `wb/get/subject/compare`**

Compare two periods for a niche.

**Query parameters:** `path` (subject ID)

---

### Niche — Keywords

**GET `wb/get/subject/by_keywords`**

Search queries and their performance for a niche.

**Query parameters:** `d1`, `d2`, `path` (subject ID)

---

### Niche — Geography

**GET `wb/get/subject/geography`**

Geographic distribution of demand for a niche.

**Query parameters:** `path` (subject ID)

---

### Niche — Similar Subjects

**GET `wb/get/subject/similar`**

Find similar niches.

**Query parameters:** `path` (subject ID)

---

### Niche — Promotion Analysis

**GET `wb/get/subjects/promotion-analysis/{subject_id}`**

Analyze promotional activity within a niche.

```bash
curl 'https://mpstats.io/api/wb/get/subjects/promotion-analysis/70' \
  --header 'X-Mpstats-TOKEN: YOUR_TOKEN'
```

---

### Niche — AI Forecast

**GET `analytics/v1/wb/subject/forecast/daily`**

Daily AI forecast for a niche.

**Query parameters:** `path` (subject ID)

**GET `analytics/v1/wb/subject/forecast/trend`**

Trend forecast for a niche.

**Query parameters:** `path` (subject ID), `period` (e.g. `month12`)

---

### Niche — Seasonal Effects

**GET `analytics/v1/wb/subject/season_effects/annual`**

Annual seasonality for a niche.

**Query parameters:** `path` (subject ID), `period` (`day`)

**GET `analytics/v1/wb/subject/season_effects/weekly`**

Weekly seasonality for a niche.

**Query parameters:** `path` (subject ID)

---

### Brand — Products

**POST `wb/get/brand`**

Get products for a brand. `path` = brand name.

**Query parameters:** `d1`, `d2`, `path` (brand name, required), `fbs`

```bash
curl --location --request POST 'https://mpstats.io/api/wb/get/brand?d1=2023-10-01&d2=2023-10-31&path=Mango&fbs=1' \
  --header 'X-Mpstats-TOKEN: YOUR_TOKEN' \
  --header 'Content-Type: application/json' \
  --data-raw '{"startRow":0,"endRow":100,"filterModel":{},"sortModel":[{"colId":"revenue","sort":"desc"}]}'
```

---

### Brand — Categories

**GET `wb/get/brand/categories`**

Categories where brand is present.

**Query parameters:** `d1`, `d2`, `path` (brand name), `fbs`

---

### Brand — Sellers

**GET `wb/get/brand/sellers`**

Sellers carrying this brand.

**Query parameters:** `d1`, `d2`, `path` (brand name), `fbs`

---

### Brand — Trend

**GET `wb/get/brand/trends`**

Trend chart for a brand.

**Query parameters:** `d1`, `d2`, `path` (brand name), `fbs`

---

### Brand — By Day

**GET `wb/get/brand/by_date`**

Brand metrics by time period.

**Query parameters:** `d1`, `d2`, `path` (brand name), `groupBy` (`day`/`week`/`month`)

---

### Brand — Warehouse Distribution

**GET `wb/get/brand/in_warehouses`**

Stock distribution across WB warehouses.

**Query parameters:** `d1`, `d2`, `path` (brand name)

---

### Brand — Price Segmentation

**GET `wb/get/brand/price_segmentation`**

Price distribution for brand products.

**Query parameters:** `d1`, `d2`, `path` (brand name), `fbs`, `spp`

---

### Brand — Compare Periods

**POST `wb/get/brand/compare`**

Compare two periods for a brand.

**Query parameters:** `path` (brand name), `fbs`

---

### Brand — Subjects (Предметы)

**GET `wb/get/brand/items`**

Subjects (product types) within a brand.

**Query parameters:** `d1`, `d2`, `path` (brand name), `fbs`

---

### Seller — Products

**POST `wb/get/seller`**

Get products for a seller. `path` = seller name.

**Query parameters:** `d1`, `d2`, `path` (seller name, required), `fbs`

```bash
curl --location --request POST 'https://mpstats.io/api/wb/get/seller?d1=2023-10-01&d2=2023-10-31&path=%D0%9E%D0%9E%D0%9E+%D0%9E%D1%81%D1%82%D0%B8%D0%BD&fbs=1' \
  --header 'X-Mpstats-TOKEN: YOUR_TOKEN' \
  --header 'Content-Type: application/json' \
  --data-raw '{"startRow":0,"endRow":100,"filterModel":{},"sortModel":[{"colId":"revenue","sort":"desc"}]}'
```

---

### Seller — Categories

**GET `wb/get/seller/categories`**

Categories where seller is present.

**Query parameters:** `d1`, `d2`, `path` (seller name), `fbs`

---

### Seller — Brands

**GET `wb/get/seller/brands`**

Brands sold by this seller.

**Query parameters:** `d1`, `d2`, `path` (seller name), `fbs`

---

### Seller — Trend

**GET `wb/get/seller/trends`**

Trend chart for a seller.

**Query parameters:** `d1`, `d2`, `path` (seller name), `fbs`

---

### Seller — By Day

**GET `wb/get/seller/by_date`**

Seller metrics by time period.

**Query parameters:** `d1`, `d2`, `path` (seller name), `fbs`, `groupBy` (`day`/`week`/`month`)

---

### Seller — Warehouse Distribution

**GET `wb/get/seller/in_warehouses`**

Stock distribution across warehouses for a seller.

**Query parameters:** `d1`, `d2`, `path` (seller name)

---

### Seller — Price Segmentation

**GET `wb/get/seller/price_segmentation`**

Price distribution for seller's products.

**Query parameters:** `d1`, `d2`, `path` (seller name), `fbs`, `spp`

---

### Seller — Compare Periods

**POST `wb/get/seller/compare`**

Compare two periods for a seller.

**Query parameters:** `path` (seller name), `fbs`

---

### Seller — Subjects (Предметы)

**GET `wb/get/seller/items`**

Subjects (product types) sold by seller.

**Query parameters:** `d1`, `d2`, `path` (seller name)

---

### Similar Products — AI (Identical)

Products grouped by AI similarity (same product from different sellers).

**POST `wb/get/identical`** — Products

```bash
curl 'https://mpstats.io/api/wb/get/identical?d1=2023-10-01&d2=2023-10-31&path=72124874&fbs=1' \
  --header 'X-Mpstats-TOKEN: YOUR_TOKEN'
```

**GET `wb/get/identical/categories`** — Categories

**GET `wb/get/identical/brands`** — Brands

**GET `wb/get/identical/sellers`** — Sellers

**GET `wb/get/identical/price_segmentation`** — Price segmentation

*For all: `path` = source SKU ID*

---

### Similar Products — WB Recommendations (Similar)

Products recommended by WB as similar.

**POST `wb/get/similar`** — Products

**GET `wb/get/similar/categories`** — Categories

**GET `wb/get/similar/brands`** — Brands

**GET `wb/get/similar/sellers`** — Sellers

**GET `wb/get/similar/price_segmentation`** — Price segmentation

---

### In Similar Products — WB (In Similar)

Products that appear in WB recommendations of the given SKU.

**GET `wb/get/in_similar`** — Products

**GET `wb/get/in_similar/categories`** — Categories

**GET `wb/get/in_similar/brands`** — Brands

**GET `wb/get/in_similar/sellers`** — Sellers

**GET `wb/get/in_similar/price_segmentation`** — Price segmentation

---

### SKU — Sales and Stock

**GET `wb/get/item/{sku}/sales`**

Daily sales and stock for a specific product.

**Query parameters:** `d1`, `d2`, `fbs`

```bash
curl 'https://mpstats.io/api/wb/get/item/148471993/sales?d1=2023-11-01&d2=2023-11-30&fbs=1' \
  --header 'X-Mpstats-TOKEN: YOUR_TOKEN'
```

---

### SKU — Daily Balance

**GET `wb/get/item/{sku}/balance_by_day`**

Stock levels by day for a specific date.

**Query parameters:** `d` (single date YYYY-MM-DD)

```bash
curl 'https://mpstats.io/api/wb/get/item/148471993/balance_by_day?d=2023-12-01' \
  --header 'X-Mpstats-TOKEN: YOUR_TOKEN'
```

---

### SKU — Stock by Warehouse

**GET `wb/get/item/{sku}/balance_by_region`**

Stock distribution across WB warehouses/regions.

**Query parameters:** `d` (single date YYYY-MM-DD)

```bash
curl 'https://mpstats.io/api/wb/get/item/148471993/balance_by_region?d=2023-12-01' \
  --header 'X-Mpstats-TOKEN: YOUR_TOKEN'
```

---

### SKU — Stock by Size

**GET `wb/get/item/{sku}/balance_by_size`**

Stock distribution by product sizes.

**Query parameters:** `d` (single date YYYY-MM-DD)

---

### SKU — Sales by Warehouse

**GET `wb/get/item/{sku}/sales_by_region`**

Sales breakdown by warehouse/region.

**Query parameters:** `d1`, `d2`

---

### SKU — Sales by Size

**GET `wb/get/item/{sku}/sales_by_size`**

Sales breakdown by product size.

**Query parameters:** `d1`, `d2`

---

### SKU — Similar Products

**GET `wb/get/item/{sku}/identical`** — AI similar products

**GET `wb/get/item/{sku}/identical_wb`** — WB AI similar products

**GET `wb/get/item/{sku}/similar`** — WB recommended similar

**GET `wb/get/item/{sku}/in_similar`** — WB products this SKU appears as similar to

*For all: `d1`, `d2`, `fbs`*

---

### SKU — Category Positions

**GET `wb/get/item/{sku}/by_category`**

Categories and positions within them over the period.

**Query parameters:** `d1`, `d2`

```bash
curl 'https://mpstats.io/api/wb/get/item/148471993/by_category?d1=2023-11-01&d2=2023-11-30' \
  --header 'X-Mpstats-TOKEN: YOUR_TOKEN'
```

---

### SKU — Keyword Positions

**GET `wb/get/item/{sku}/by_keywords`**

Search queries and positions for a product.

**Query parameters:** `d1`, `d2`

```bash
curl 'https://mpstats.io/api/wb/get/item/148471993/by_keywords?d1=2023-11-01&d2=2023-11-30' \
  --header 'X-Mpstats-TOKEN: YOUR_TOKEN'
```

---

### SKU — Card History (Versions)

**GET `wb/get/item/{sku}/full_page/versions`**

Get list of card versions (change history).

```bash
curl 'https://mpstats.io/api/wb/get/item/148471993/full_page/versions' \
  --header 'X-Mpstats-TOKEN: YOUR_TOKEN'
```

**GET `wb/get/item/{sku}/full_page`**

Get full card data for a specific version.

**Query parameters:** `version` (version hash from versions list)

```bash
curl 'https://mpstats.io/api/wb/get/item/148471993/full_page?version=7fba9f25f1c765a083bdedafbef2d0be' \
  --header 'X-Mpstats-TOKEN: YOUR_TOKEN'
```

---

### SKU — Reviews History

**GET `wb/get/item/{sku}/comments`**

Review history for a product.

```bash
curl 'https://mpstats.io/api/wb/get/item/148471993/comments' \
  --header 'X-Mpstats-TOKEN: YOUR_TOKEN'
```

---

## Ozon API

Base prefix: `oz/`

### Catalog — Get All Categories

**GET `oz/get/categories`**

Returns all Ozon categories.

```bash
curl 'https://mpstats.io/api/oz/get/categories' \
  --header 'X-Mpstats-TOKEN: YOUR_TOKEN'
```

---

### Category — Products

**POST `oz/get/category`**

Products in an Ozon category.

**Query parameters:** `d1`, `d2`, `path` (required)

**Request body:** standard pagination/sort/filter object

---

### Category — Subcategories

**GET `oz/get/category/subcategories`**

Subcategory analytics.

**Query parameters:** `d1`, `d2`, `path` (required)

---

### Category — Sellers

**GET `oz/get/category/sellers`**

Sellers within an Ozon category.

**Query parameters:** `d1`, `d2`, `path` (required)

---

### Category — Brands

**GET `oz/get/category/brands`**

Brands within an Ozon category.

**Query parameters:** `d1`, `d2`, `path` (required)

---

### Category — By Day

**GET `oz/get/category/by_date`**

Category metrics by time period.

**Query parameters:** `d1`, `d2`, `path` (required), `groupBy`

---

### Category — Price Segmentation

**GET `oz/get/category/price_segmentation`**

Price distribution in an Ozon category.

**Query parameters:** `d1`, `d2`, `path` (required)

---

### Category — Compare Periods

**POST `oz/get/category/compare`**

Compare two periods for an Ozon category.

---

### Brand — Products (Ozon)

**POST `oz/get/brands`**

Products for an Ozon brand.

**Query parameters:** `d1`, `d2`, `path` (brand name, required)

---

### Brand — Categories (Ozon)

**GET `oz/get/brand/categories`**

**Brand — Sellers (Ozon)**

**GET `oz/get/brand/sellers`**

**Brand — By Day (Ozon)**

**GET `oz/get/brand/by_date`**

**Brand — Price Segmentation (Ozon)**

**GET `oz/get/brand/price_segmentation`**

**Brand — Compare Periods (Ozon)**

**POST `oz/get/brand/compare`**

---

### Seller — Products (Ozon)

**POST `oz/get/seller`**

Products for an Ozon seller.

**Query parameters:** `d1`, `d2`, `path` (seller name, required)

**Seller — Categories (Ozon)**

**GET `oz/get/seller/categories`**

**Seller — Brands (Ozon)**

**GET `oz/get/seller/brands`**

**Seller — By Day (Ozon)**

**GET `oz/get/seller/by_date`**

**Seller — Price Segmentation (Ozon)**

**GET `oz/get/seller/price_segmentation`**

**Seller — Compare Periods (Ozon)**

**POST `oz/get/seller/compare`**

---

### SKU — Sales and Stock (Ozon)

**GET `oz/get/item/{sku}/sales`**

Daily sales and stock for an Ozon product.

**Query parameters:** `d1`, `d2`

---

### SKU — Daily Balance (Ozon)

**GET `oz/get/item/{sku}/balance_by_day`**

**Query parameters:** `d`

---

### SKU — Stock by Warehouse (Ozon)

**GET `oz/get/item/{sku}/balance_by_region`**

**Query parameters:** `d`

---

### SKU — Category Positions (Ozon)

**GET `oz/get/item/{sku}/by_category`**

**Query parameters:** `d1`, `d2`

---

### SKU — Keyword Positions (Ozon)

**GET `oz/get/item/{sku}/by_keywords`**

**Query parameters:** `d1`, `d2`

---

## Yandex Market API

Base prefix: `ym/`

### Category — Products

**POST `ym/get/category`**

Products in a Yandex Market category.

**Query parameters:** `d1`, `d2`, `path` (required)

---

### Category — Subcategories

**GET `ym/get/category/categories`**

**Category — Sellers (YM)**

**GET `ym/get/category/sellers`**

**Category — Brands (YM)**

**GET `ym/get/category/brands`**

**Category — By Day (YM)**

**GET `ym/get/category/by_date`**

**Category — Price Segmentation (YM)**

**GET `ym/get/category/price_segmentation`**

**Category — Compare Periods (YM)**

**POST `ym/get/category/compare`**

---

### Brand — Products (YM)

**POST `ym/get/brand`**

**Brand — Categories (YM)**

**GET `ym/get/brand/categories`**

**Brand — Sellers (YM)**

**GET `ym/get/brand/sellers`**

**Brand — By Day (YM)**

**GET `ym/get/brand/by_date`**

**Brand — Price Segmentation (YM)**

**GET `ym/get/brand/price_segmentation`**

**Brand — Compare Periods (YM)**

**POST `ym/get/brand/compare`**

---

### Seller — Products (YM)

**POST `ym/get/seller`**

**Seller — Categories (YM)**

**GET `ym/get/seller/categories`**

**Seller — Brands (YM)**

**GET `ym/get/seller/brands`**

**Seller — By Day (YM)**

**GET `ym/get/seller/by_date`**

**Seller — Price Segmentation (YM)**

**GET `ym/get/seller/price_segmentation`**

**Seller — Compare Periods (YM)**

**POST `ym/get/seller/compare`**

---

### SKU — Sales and Stock (YM)

**GET `ym/get/item/{id}/sales`**

**Query parameters:** `d1`, `d2`

---

## Account API

### Get Report Limits

**GET `user/report_api_limit`**

Check remaining API request quota for your account.

```bash
curl 'https://mpstats.io/api/user/report_api_limit' \
  --header 'X-Mpstats-TOKEN: YOUR_TOKEN' \
  --header 'Content-Type: application/json'
```

**Response:**
```json
{
  "available": 2500,
  "use": 38
}
```

| Field | Type | Description |
|-------|------|-------------|
| `available` | number | Total API requests available in plan |
| `use` | number | Requests used in current period |

---

## Code Examples

### TypeScript — Fetch Category Products

```typescript
const MPSTATS_TOKEN = process.env.MPSTATS_TOKEN;
const BASE_URL = 'https://mpstats.io/api';

interface MpstatsResponse<T> {
  startRow: number;
  endRow: number;
  total: number;
  data: T[];
}

interface WbProduct {
  id: number;
  name: string;
  brand: string;
  seller: string;
  sales: number;
  revenue: number;
  final_price: number;
  balance: number;
  rating: number;
  comments: number;
}

async function getCategoryProducts(
  category: string,
  d1: string,
  d2: string,
  limit = 100
): Promise<MpstatsResponse<WbProduct>> {
  const url = new URL(`${BASE_URL}/wb/get/category`);
  url.searchParams.set('path', category);
  url.searchParams.set('d1', d1);
  url.searchParams.set('d2', d2);

  const response = await fetch(url.toString(), {
    method: 'POST',
    headers: {
      'X-Mpstats-TOKEN': MPSTATS_TOKEN!,
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      startRow: 0,
      endRow: limit,
      filterModel: {},
      sortModel: [{ colId: 'revenue', sort: 'desc' }],
    }),
  });

  if (!response.ok) {
    const error = await response.json();
    throw new Error(`MPSTATS API error ${response.status}: ${error.message}`);
  }

  return response.json();
}

// Usage
const products = await getCategoryProducts(
  'Женщинам/Одежда/Платья',
  '2023-11-01',
  '2023-11-30'
);
console.log(`Total: ${products.total}, fetched: ${products.data.length}`);
```

---

### TypeScript — Fetch SKU Sales History

```typescript
async function getSkuSales(sku: number, d1: string, d2: string) {
  const response = await fetch(
    `${BASE_URL}/wb/get/item/${sku}/sales?d1=${d1}&d2=${d2}`,
    {
      headers: {
        'X-Mpstats-TOKEN': MPSTATS_TOKEN!,
        'Content-Type': 'application/json',
      },
    }
  );

  if (response.status === 202) {
    // Data is being processed, retry after delay
    const retryAfter = response.headers.get('Retry-After') || '5';
    await new Promise(resolve => setTimeout(resolve, parseInt(retryAfter) * 1000));
    return getSkuSales(sku, d1, d2);
  }

  return response.json();
}

// Usage
const sales = await getSkuSales(148471993, '2023-11-01', '2023-11-30');
```

---

### TypeScript — Check API Limits

```typescript
async function checkApiLimits() {
  const response = await fetch(`${BASE_URL}/user/report_api_limit`, {
    headers: { 'X-Mpstats-TOKEN': MPSTATS_TOKEN! },
  });
  const { available, use } = await response.json();
  console.log(`API limit: ${use}/${available} used`);
  return { available, use, remaining: available - use };
}
```

---

### Python — Category Analytics

```python
import requests
from typing import Any

MPSTATS_TOKEN = "your_token_here"
BASE_URL = "https://mpstats.io/api"

def get_category_products(
    category: str,
    d1: str,
    d2: str,
    limit: int = 100,
    sort_by: str = "revenue",
    fbs: bool = False,
) -> dict[str, Any]:
    """Fetch products from a WB category with sales analytics."""
    params = {"path": category, "d1": d1, "d2": d2}
    if fbs:
        params["fbs"] = "1"

    body = {
        "startRow": 0,
        "endRow": limit,
        "filterModel": {},
        "sortModel": [{"colId": sort_by, "sort": "desc"}],
    }

    response = requests.post(
        f"{BASE_URL}/wb/get/category",
        params=params,
        json=body,
        headers={
            "X-Mpstats-TOKEN": MPSTATS_TOKEN,
            "Content-Type": "application/json",
        },
    )
    response.raise_for_status()
    return response.json()


def get_niche_brands(subject_id: int, d1: str, d2: str) -> list[dict]:
    """Get brand rankings within a WB niche (subject)."""
    response = requests.get(
        f"{BASE_URL}/wb/get/subject/brands",
        params={"path": subject_id, "d1": d1, "d2": d2},
        headers={"X-Mpstats-TOKEN": MPSTATS_TOKEN},
    )
    response.raise_for_status()
    return response.json()


def get_sku_sales(sku: int, d1: str, d2: str) -> list[dict]:
    """Get daily sales and stock data for a WB product SKU."""
    response = requests.get(
        f"{BASE_URL}/wb/get/item/{sku}/sales",
        params={"d1": d1, "d2": d2},
        headers={"X-Mpstats-TOKEN": MPSTATS_TOKEN},
    )
    response.raise_for_status()
    return response.json()


def get_api_limits() -> dict:
    """Check remaining API quota."""
    response = requests.get(
        f"{BASE_URL}/user/report_api_limit",
        headers={"X-Mpstats-TOKEN": MPSTATS_TOKEN},
    )
    response.raise_for_status()
    return response.json()


# Example: Find top revenue products in Дresses niche
if __name__ == "__main__":
    result = get_category_products(
        category="Женщинам/Платья и сарафаны",
        d1="2023-11-01",
        d2="2023-11-30",
        limit=50,
    )
    print(f"Total products in category: {result['total']}")
    for product in result['data'][:5]:
        print(f"  {product['name']}: {product['revenue']:,} RUB revenue, {product['sales']} sales")
```

---

### Python — Paginate All Products in Category

```python
def get_all_category_products(category: str, d1: str, d2: str) -> list[dict]:
    """Fetch all products using pagination (max 5000 per batch)."""
    all_products = []
    batch_size = 5000
    start = 0

    while True:
        body = {
            "startRow": start,
            "endRow": start + batch_size,
            "filterModel": {},
            "sortModel": [{"colId": "revenue", "sort": "desc"}],
        }
        data = requests.post(
            f"{BASE_URL}/wb/get/category",
            params={"path": category, "d1": d1, "d2": d2},
            json=body,
            headers={"X-Mpstats-TOKEN": MPSTATS_TOKEN},
        ).json()

        batch = data["data"]
        all_products.extend(batch)

        if len(all_products) >= data["total"] or len(batch) < batch_size:
            break
        start += batch_size

    return all_products
```

---

## Rate Limits and Best Practices

1. **Rate limiting**: When you receive HTTP 429, check the `Retry-After` header for the wait time in seconds before retrying.

2. **HTTP 202**: Means the server accepted the request but data is still being computed. Retry the same request after a few seconds.

3. **Date ranges**: On Basic and Extended tariffs, `d1` and `d2` are fixed by plan terms and cannot be changed. On Professional and above plans, you can specify any date range.

4. **FBS data**: By default, FBS (Fulfillment by Seller) products are excluded. Add `fbs=1` to include them.

5. **Pagination**: Maximum 5000 records per request. Use `startRow`/`endRow` to paginate through larger datasets.

6. **URL encoding**: Category paths containing Cyrillic characters must be URL-encoded. Python's `requests` handles this automatically via `params=`. In curl, encode manually or use `--data-urlencode`.

7. **Field names**: The API uses `snake_case` for all field names in JSON responses.

---

## Endpoint Quick Reference

### Wildberries

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `wb/get/categories` | Full category tree |
| POST | `wb/get/category` | Products in category |
| GET | `wb/get/category/subcategories` | Subcategory stats |
| GET | `wb/get/category/brands` | Brands in category |
| GET | `wb/get/category/sellers` | Sellers in category |
| GET | `wb/get/category/trends` | Category trend chart |
| GET | `wb/get/category/by_date` | Category by day/week/month |
| GET | `wb/get/category/price_segmentation` | Price distribution |
| POST | `wb/get/category/compare` | Compare periods |
| GET | `wb/get/category/items` | Subjects in category |
| GET | `analytics/v1/wb/category/forecast/daily` | AI daily forecast |
| GET | `analytics/v1/wb/category/forecast/trend` | AI trend forecast |
| GET | `analytics/v1/wb/category/season_effects/annual` | Annual seasonality |
| GET | `analytics/v1/wb/category/season_effects/weekly` | Weekly seasonality |
| GET | `wb/get/subjects/select` | All subjects list |
| POST | `wb/get/subject` | Products in niche |
| GET | `wb/get/subject/categories` | Categories for niche |
| GET | `wb/get/subject/brands` | Brands in niche |
| GET | `wb/get/subject/sellers` | Sellers in niche |
| GET | `wb/get/subject/trends` | Niche trend |
| GET | `wb/get/subject/by_date` | Niche by date |
| GET | `wb/get/subject/price_segmentation` | Niche price segments |
| POST | `wb/get/subject/compare` | Compare niche periods |
| GET | `wb/get/subject/by_keywords` | Niche search queries |
| GET | `wb/get/subject/geography` | Geographic demand |
| GET | `wb/get/subject/similar` | Similar niches |
| GET | `wb/get/subjects/promotion-analysis/{id}` | Promo analysis |
| GET | `analytics/v1/wb/subject/forecast/daily` | AI niche forecast |
| GET | `analytics/v1/wb/subject/forecast/trend` | AI niche trend |
| GET | `analytics/v1/wb/subject/season_effects/annual` | Niche annual seasonality |
| GET | `analytics/v1/wb/subject/season_effects/weekly` | Niche weekly seasonality |
| POST | `wb/get/brand` | Products by brand |
| GET | `wb/get/brand/categories` | Brand categories |
| GET | `wb/get/brand/sellers` | Brand sellers |
| GET | `wb/get/brand/trends` | Brand trend |
| GET | `wb/get/brand/by_date` | Brand by date |
| GET | `wb/get/brand/in_warehouses` | Brand warehouse stock |
| GET | `wb/get/brand/price_segmentation` | Brand price segments |
| POST | `wb/get/brand/compare` | Compare brand periods |
| GET | `wb/get/brand/items` | Brand subjects |
| POST | `wb/get/seller` | Products by seller |
| GET | `wb/get/seller/categories` | Seller categories |
| GET | `wb/get/seller/brands` | Seller brands |
| GET | `wb/get/seller/trends` | Seller trend |
| GET | `wb/get/seller/by_date` | Seller by date |
| GET | `wb/get/seller/in_warehouses` | Seller warehouse stock |
| GET | `wb/get/seller/price_segmentation` | Seller price segments |
| POST | `wb/get/seller/compare` | Compare seller periods |
| GET | `wb/get/seller/items` | Seller subjects |
| POST | `wb/get/identical` | AI similar products |
| GET | `wb/get/identical/categories` | Similar — categories |
| GET | `wb/get/identical/brands` | Similar — brands |
| GET | `wb/get/identical/sellers` | Similar — sellers |
| GET | `wb/get/identical/price_segmentation` | Similar — price |
| POST | `wb/get/similar` | WB recommended similar |
| GET | `wb/get/similar/categories` | WB similar — categories |
| GET | `wb/get/similar/brands` | WB similar — brands |
| GET | `wb/get/similar/sellers` | WB similar — sellers |
| GET | `wb/get/similar/price_segmentation` | WB similar — price |
| GET | `wb/get/in_similar` | Products this SKU is similar to |
| GET | `wb/get/in_similar/categories` | In similar — categories |
| GET | `wb/get/in_similar/brands` | In similar — brands |
| GET | `wb/get/in_similar/sellers` | In similar — sellers |
| GET | `wb/get/in_similar/price_segmentation` | In similar — price |
| GET | `wb/get/item/{sku}/sales` | SKU daily sales |
| GET | `wb/get/item/{sku}/balance_by_day` | SKU daily stock |
| GET | `wb/get/item/{sku}/balance_by_region` | SKU stock by warehouse |
| GET | `wb/get/item/{sku}/balance_by_size` | SKU stock by size |
| GET | `wb/get/item/{sku}/sales_by_region` | SKU sales by warehouse |
| GET | `wb/get/item/{sku}/sales_by_size` | SKU sales by size |
| GET | `wb/get/item/{sku}/identical` | AI identical products |
| GET | `wb/get/item/{sku}/identical_wb` | WB AI identical |
| GET | `wb/get/item/{sku}/similar` | WB similar products |
| GET | `wb/get/item/{sku}/in_similar` | SKU appears as similar in |
| GET | `wb/get/item/{sku}/by_category` | SKU category positions |
| GET | `wb/get/item/{sku}/by_keywords` | SKU keyword positions |
| GET | `wb/get/item/{sku}/full_page/versions` | Card history versions |
| GET | `wb/get/item/{sku}/full_page` | Card data by version |
| GET | `wb/get/item/{sku}/comments` | Reviews history |

### Ozon

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `oz/get/categories` | Full category tree |
| POST | `oz/get/category` | Products in category |
| GET | `oz/get/category/subcategories` | Subcategory stats |
| GET | `oz/get/category/sellers` | Sellers in category |
| GET | `oz/get/category/brands` | Brands in category |
| GET | `oz/get/category/by_date` | Category by date |
| GET | `oz/get/category/price_segmentation` | Price distribution |
| POST | `oz/get/category/compare` | Compare periods |
| POST | `oz/get/brands` | Products by brand |
| GET | `oz/get/brand/categories` | Brand categories |
| GET | `oz/get/brand/sellers` | Brand sellers |
| GET | `oz/get/brand/by_date` | Brand by date |
| GET | `oz/get/brand/price_segmentation` | Brand price segments |
| POST | `oz/get/brand/compare` | Compare brand periods |
| POST | `oz/get/seller` | Products by seller |
| GET | `oz/get/seller/categories` | Seller categories |
| GET | `oz/get/seller/brands` | Seller brands |
| GET | `oz/get/seller/by_date` | Seller by date |
| GET | `oz/get/seller/price_segmentation` | Seller price segments |
| POST | `oz/get/seller/compare` | Compare seller periods |
| GET | `oz/get/item/{sku}/sales` | SKU daily sales |
| GET | `oz/get/item/{sku}/balance_by_day` | SKU daily stock |
| GET | `oz/get/item/{sku}/balance_by_region` | SKU stock by warehouse |
| GET | `oz/get/item/{sku}/by_category` | SKU category positions |
| GET | `oz/get/item/{sku}/by_keywords` | SKU keyword positions |

### Yandex Market

| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `ym/get/category` | Products in category |
| GET | `ym/get/category/categories` | Subcategories |
| GET | `ym/get/category/sellers` | Sellers in category |
| GET | `ym/get/category/brands` | Brands in category |
| GET | `ym/get/category/by_date` | Category by date |
| GET | `ym/get/category/price_segmentation` | Price distribution |
| POST | `ym/get/category/compare` | Compare periods |
| POST | `ym/get/brand` | Products by brand |
| GET | `ym/get/brand/categories` | Brand categories |
| GET | `ym/get/brand/sellers` | Brand sellers |
| GET | `ym/get/brand/by_date` | Brand by date |
| GET | `ym/get/brand/price_segmentation` | Brand price segments |
| POST | `ym/get/brand/compare` | Compare brand periods |
| POST | `ym/get/seller` | Products by seller |
| GET | `ym/get/seller/categories` | Seller categories |
| GET | `ym/get/seller/brands` | Seller brands |
| GET | `ym/get/seller/by_date` | Seller by date |
| GET | `ym/get/seller/price_segmentation` | Seller price segments |
| POST | `ym/get/seller/compare` | Compare seller periods |
| GET | `ym/get/item/{id}/sales` | SKU daily sales |

### Account

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `user/report_api_limit` | API quota remaining |

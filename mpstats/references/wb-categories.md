# Wildberries — Categories & Niche Analysis

All endpoints: `GET` or `POST` to `https://mpstats.io/api/<path>`

---

## Rubricator

### GET wb/get/categories
Get the current WB rubricator (full category tree).

**Response:**
```json
[
  { "url": "/catalog/premium-odezhda", "name": "Premium", "path": "Premium" },
  { "url": "/catalog/zhenshchinam/odezhda/svitshoty", "name": "Свитшоты", "path": "Женщинам/Одежда/Свитшоты" },
  { "url": "/catalog/elektronika/planshety", "name": "Планшеты", "path": "Электроника/Смартфоны и телефоны/Планшеты" }
]
```

| Field | Type   | Description |
|-------|--------|-------------|
| `url` | string | WB catalog URL path |
| `name`| string | Category name |
| `path`| string | Full path from root |

---

## Category: Products

### POST wb/get/category
Get products in a category for a date range.

**Query params:**
| Param  | Type   | Required | Description |
|--------|--------|----------|-------------|
| `d1`   | string | yes      | Start date `YYYY-MM-DD` |
| `d2`   | string | yes      | End date `YYYY-MM-DD` |
| `path` | string | yes      | URL-encoded category path (e.g. `Женщинам/Одежда`) |
| `fbs`  | int    | no       | Include FBS (1 = yes) |

**Request body:** See `pagination-filter-sort.md`

**Response data item fields:**
| Field | Description |
|-------|-------------|
| `id` | WB SKU |
| `name` | Product name |
| `brand` | Brand name |
| `seller` | Seller name |
| `supplier_id` | Seller ID |
| `color` | Color |
| `balance` | Current stock |
| `balance_fbs` | FBS stock |
| `comments` | Review count |
| `rating` | Rating (0–5) |
| `final_price` | Final price (RUB) |
| `final_price_max/min/average/median` | Price stats |
| `basic_sale` | Basic discount % |
| `basic_price` | Price before discount |
| `promo_sale` | Promo discount % |
| `client_sale` | Client discount % |
| `client_price` | Price with client discount |
| `start_price` | Original price |
| `sales` | Sales count in period |
| `sales_per_day_average` | Average daily sales |
| `revenue` | Revenue in period (RUB) |
| `revenue_potential` | Potential revenue |
| `revenue_average` | Average revenue |
| `lost_profit` | Lost profit |
| `lost_profit_percent` | Lost profit % |
| `days_in_stock` | Days in stock |
| `days_with_sales` | Days with sales |
| `average_if_in_stock` | Avg sales if in stock |
| `is_fbs` | Is FBS (1/0) |
| `subject_id` | Subject ID |
| `subject` | Subject name |
| `purchase` | Add-to-cart count |
| `purchase_after_return` | Purchase after return |
| `country` | Country of origin |
| `gender` | Gender target |
| `sku_first_date` | First appearance date |
| `firstcommentdate` | First review date |
| `picscount` | Image count |
| `has3d` | Has 3D (1/0) |
| `hasvideo` | Has video (1/0) |
| `commentsvaluation` | Comment quality score |
| `cardratingval` | Card rating value |
| `categories_last_count` | Categories count |
| `category` | Primary category path |
| `category_position` | Position in category |
| `product_visibility_graph` | Visibility over time |
| `category_graph` | Category position history |
| `graph` | Sales history array |
| `stocks_graph` | Stock history array |
| `price_graph` | Price history array |
| `thumb` | Thumbnail URL (small) |
| `thumb_middle` | Thumbnail URL (medium) |
| `url` | WB product URL |
| `turnover_days` | Turnover in days |
| `turnover_once` | Turnover coefficient |

---

## Category: Subcategories

### GET wb/get/category/subcategories
Get subcategory breakdown for a category.

**Query params:**
| Param  | Type   | Required | Description |
|--------|--------|----------|-------------|
| `d1`   | string | yes      | Start date |
| `d2`   | string | yes      | End date |
| `path` | string | yes      | URL-encoded category path |
| `fbs`  | int    | no       | Include FBS |

**Response item fields:**
| Field | Description |
|-------|-------------|
| `name` | Subcategory name |
| `items` | Total products |
| `items_with_sells` | Products with sales |
| `brands` | Total brands |
| `brands_with_sells` | Brands with sales |
| `sellers` | Total sellers |
| `sellers_with_sells` | Sellers with sales |
| `sales` | Total sales |
| `revenue` | Total revenue (RUB) |
| `avg_price` | Average price |
| `comments` | Average comment count |
| `rating` | Average rating |
| `items_with_sells_percent` | % products with sales |
| `brands_with_sells_percent` | % brands with sales |
| `sellers_with_sells_percent` | % sellers with sales |
| `sales_per_items_average` | Avg sales per product |
| `sales_per_items_with_sells_average` | Avg sales per selling product |
| `revenue_per_items_average` | Avg revenue per product |
| `revenue_per_items_with_sells_average` | Avg revenue per selling product |

---

## Category: Brands

### GET wb/get/category/brands
Get brand breakdown for a category.

**Query params:** `d1`, `d2`, `path`, `fbs`

---

## Category: Sellers

### GET wb/get/category/sellers
Get seller breakdown for a category.

**Query params:** `d1`, `d2`, `path`, `fbs`

---

## Category: Trend

### GET wb/get/category/trends
Get trend data for a category.

**Query params:** `d1`, `d2`, `path`, `fbs`

---

## Category: By Date

### GET wb/get/category/by_date
Get category metrics aggregated by day.

**Query params:** `d1`, `d2`, `path`, `fbs`

---

## Category: Price Segmentation

### GET wb/get/category/price_segmentation
Get price segment breakdown for a category.

**Query params:** `d1`, `d2`, `path`, `fbs`

---

## Category: Period Comparison

### POST wb/get/category/compare
Compare two periods for a category.

**Query params:** `d1`, `d2`, `path`, `fbs`
**Body:** pagination/filter/sort model

---

## Category: Subjects (Items)

### GET wb/get/category/items
Get subjects (product types) in a category.

**Query params:** `d1`, `d2`, `path`

---

## AI Forecasts (Category)

### GET analytics/v1/wb/category/forecast/daily
Daily forecast chart for a category.

### GET analytics/v1/wb/category/forecast/trend
Trend forecast for a category.

---

## Seasonal Effects (Category)

### GET analytics/v1/wb/category/season_effects/annual
Annual seasonality, holidays and sales events (%).

### GET analytics/v1/wb/category/season_effects/weekly
Weekly seasonality chart (%).

---

## Niche (Subject) Analysis

Subjects are WB's product type taxonomy (e.g. "Платья", "Кроссовки").

### GET wb/get/subjects/select
Get list of subjects/niches for selection.

**Query params:** `d1`, `d2`

---

### POST api/wb/get/subject
Get products for a subject/niche.

**Query params:** `d1`, `d2`, subject identifier, `fbs`
**Body:** pagination/filter/sort model

---

### GET wb/get/subject/categories
Get category breakdown for a subject.

**Query params:** `d1`, `d2`, subject identifier

---

### GET wb/get/subject/brands
Get brand breakdown for a subject.

**Query params:** `d1`, `d2`, subject identifier

---

### GET wb/get/subject/sellers
Get seller breakdown for a subject.

**Query params:** `d1`, `d2`, subject identifier

---

### GET wb/get/subject/trends
Get trend data for a subject.

**Query params:** `d1`, `d2`, subject identifier

---

### GET wb/get/subject/by_date
Get subject metrics by day.

**Query params:** `d1`, `d2`, subject identifier

---

### GET wb/get/category/price_segmentation
Get price segmentation for a subject (same endpoint as category).

---

### POST wb/get/subject/compare
Compare two periods for a subject.

---

### GET wb/get/subject/by_keywords
Get keyword/search query data for a subject.

---

### GET wb/get/subject/geography
Get geographic distribution for a subject.
**Status:** temporarily disabled in wrappers due to unstable API responses.
**Query params:** `path` (required), `fbs` (optional). `d1/d2` are not accepted for this method.

---

### GET wb/get/subject/similar
Get similar subjects.

---

### GET wb/get/subjects/promotion-analysis
Get promotion analysis for subjects.

---

## Subject AI Forecasts

### GET analytics/v1/wb/subject/forecast/daily
Daily forecast for a subject.

### GET analytics/v1/wb/subject/forecast/trend
Trend forecast for a subject.

---

## Subject Seasonal Effects

### GET analytics/v1/wb/subject/season_effects/annual
Annual seasonality for a subject (%).

### GET analytics/v1/wb/subject/season_effects/weekly
Weekly seasonality for a subject (%).

---

Use script wrappers:
- `scripts/wb/wb-categories-list.sh`
- `scripts/wb/wb-category.sh`
- `scripts/wb/wb-category-stats.sh`
- `scripts/wb/wb-search.sh`
- `scripts/wb/wb-subject.sh`
- `scripts/wb/wb-analytics.sh`
- `scripts/wb/wb-promotion-analysis.sh`
- `scripts/wb/wb-compare.sh`
- `scripts/request.sh` (for any method not covered by dedicated wrappers)

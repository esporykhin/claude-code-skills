# Ozon — Categories Analytics

All endpoints: `GET` or `POST` to `https://mpstats.io/api/<path>`

---

## Rubricator

### GET oz/get/categories
Get the current Ozon category rubricator.

```bash
curl --location --request GET 'https://mpstats.io/api/oz/get/categories' \
  --header 'X-Mpstats-TOKEN: YOUR_TOKEN' \
  --header 'Content-Type: application/json'
```

**Response:**
```json
[
  { "url": "/category/avtotovary-8500/", "path": "Автотовары", "name": "Автотовары" },
  { "url": "/category/chehly-i-nakidki-na-sidenya-8640/", "path": "Автотовары/Автоаксессуары и принадлежности/Чехлы и накидки на сиденья", "name": "Чехлы и накидки на сиденья" },
  { "url": "/category/semena-lna-9481/", "path": "Продукты питания/Орехи, снэки/Семена льна", "name": "Семена льна" }
]
```

| Field  | Type   | Description |
|--------|--------|-------------|
| `url`  | string | Ozon category URL path |
| `path` | string | Full path from root |
| `name` | string | Category name |

---

## Category: Products

### POST oz/get/category
Get products in an Ozon category for a date range.

**Query params:**
| Param  | Type   | Required | Description |
|--------|--------|----------|-------------|
| `d1`   | string | yes      | Start date `YYYY-MM-DD` |
| `d2`   | string | yes      | End date `YYYY-MM-DD` |
| `path` | string | yes      | URL-encoded category path |
| `fbs`  | int    | no       | Include FBS (1 = yes) |

**Body:** See `pagination-filter-sort.md`

**Response:** Product list with fields similar to WB (id, name, brand, seller, price, sales, revenue, balance, rating, comments, etc.)

---

## Category: Subcategories

### GET oz/get/category/subcategories
Get subcategory breakdown for an Ozon category.

**Query params:** `d1`, `d2`, `path`, `fbs`

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
| `comments` | Average comments |
| `rating` | Average rating |
| `items_with_sells_percent` | % products with sales |
| `brands_with_sells_percent` | % brands with sales |
| `sellers_with_sells_percent` | % sellers with sales |
| `sales_per_items_average` | Avg sales per product |
| `sales_per_items_with_sells_average` | Avg sales per selling product |
| `revenue_per_items_average` | Avg revenue per product |
| `revenue_per_items_with_sells_average` | Avg revenue per selling product |

---

## Category: Sellers

### GET oz/get/category/sellers
Get seller breakdown for an Ozon category.

**Query params:** `d1`, `d2`, `path`, `fbs`

---

## Category: Brands

### GET oz/get/category/brands
Get brand breakdown for an Ozon category.

**Query params:** `d1`, `d2`, `path`, `fbs`

---

## Category: By Date

### GET oz/get/category/by_date
Get Ozon category metrics aggregated by day.

**Query params:** `d1`, `d2`, `path`, `fbs`

---

## Category: Price Segmentation

### GET oz/get/category/price_segmentation
Get price segment breakdown for an Ozon category.

**Query params:** `d1`, `d2`, `path`, `fbs`

---

## Category: Period Comparison

### POST oz/get/category/compare
Compare two periods for an Ozon category.

**Query params:** `d1`, `d2`, `path`, `fbs`
**Body:** pagination/filter/sort model

---

Use script wrappers:
- `scripts/ozon-categories-list.sh`
- `scripts/ozon-category.sh`

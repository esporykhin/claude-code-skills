# Ozon — Brands, Sellers & SKU Analytics

All endpoints: `GET` or `POST` to `https://mpstats.io/api/<path>`

---

## Brands

### POST oz/get/brand
Get products for an Ozon brand.
Note: some docs/examples mention `oz/get/brands`; wrapper supports this via fallback.

**Query params:**
| Param   | Type   | Required | Description |
|---------|--------|----------|-------------|
| `d1`    | string | yes      | Start date `YYYY-MM-DD` |
| `d2`    | string | yes      | End date `YYYY-MM-DD` |
| `path`  | string | yes      | Brand name (URL-encoded) |
| `fbs`   | int    | no       | Include FBS (1 = yes) |

**Body:** See `pagination-filter-sort.md`

---

### GET oz/get/brand/categories
Get category breakdown for an Ozon brand.

**Query params:** `d1`, `d2`, `path`, `fbs`

---

### GET oz/get/brand/sellers
Get sellers for an Ozon brand.

**Query params:** `d1`, `d2`, `path`, `fbs`

---

### GET oz/get/brand/by_date
Get brand metrics by day.

**Query params:** `d1`, `d2`, `path`, `fbs`

---

### GET oz/get/brand/price_segmentation
Get price segmentation for an Ozon brand.

**Query params:** `d1`, `d2`, `path`, `fbs`

---

### POST oz/get/brand/compare
Compare two periods for an Ozon brand.

**Query params:** `d1`, `d2`, `path`, `fbs`
**Body:** pagination/filter/sort model

---

## Sellers

### POST oz/get/seller
Get products for an Ozon seller.

**Query params:**
| Param       | Type   | Required | Description |
|-------------|--------|----------|-------------|
| `d1`        | string | yes      | Start date |
| `d2`        | string | yes      | End date |
| `path`      | string | yes      | Seller identifier (name or id as path) |
| `fbs`       | int    | no       | Include FBS |

**Body:** See `pagination-filter-sort.md`

---

### GET oz/get/seller/categories
Get category breakdown for an Ozon seller.

**Query params:** `d1`, `d2`, `path` (or `seller_id`), `fbs`

---

### GET oz/get/seller/brands
Get brands for an Ozon seller.

**Query params:** `d1`, `d2`, `path` (or `seller_id`), `fbs`

---

### GET oz/get/seller/by_date
Get seller metrics by day.

**Query params:** `d1`, `d2`, `path` (or `seller_id`), `fbs`

---

### GET oz/get/seller/price_segmentation
Get price segmentation for an Ozon seller.

**Query params:** `d1`, `d2`, `path` (or `seller_id`), `fbs`

---

### POST oz/get/seller/compare
Compare two periods for an Ozon seller.

**Query params:** `d1`, `d2`, `path` (or `seller_id`), `fbs`
**Body:** pagination/filter/sort model

---

## SKU-Level Analytics

### GET oz/get/item/{sku}/sales
Get sales and stock history for an Ozon SKU.

---

### GET oz/get/item/{sku}/balance_by_day
Get intra-day balances/sales snapshots for a specific date.

**Query params:** `d`

---

### GET oz/get/item/{sku}/balance_by_region
Get stock by warehouse/region for a specific date.

**Query params:** `d`, optional `fbs`

---

### GET oz/get/item/{sku}/by_category
Get category positions history for a date range.

**Query params:** `d1`, `d2`

---

### GET oz/get/item/{sku}/by_keywords
Get keyword positions history for a date range.

**Query params:** `d1`, `d2`

---

Use script wrappers:
- `scripts/ozon/ozon-brand.sh`
- `scripts/ozon/ozon-seller.sh`
- `scripts/ozon/ozon-sku.sh`
- `scripts/ozon/ozon-compare.sh`
- `scripts/request.sh` (for any method not covered by dedicated wrappers)

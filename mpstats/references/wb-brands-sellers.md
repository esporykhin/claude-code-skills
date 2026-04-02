# Wildberries — Brands & Sellers Analytics

All endpoints: `GET` or `POST` to `https://mpstats.io/api/<path>`

---

## Brands

### POST wb/get/brand
Get products for a brand.

**Query params:**
| Param  | Type   | Required | Description |
|--------|--------|----------|-------------|
| `d1`   | string | yes      | Start date `YYYY-MM-DD` |
| `d2`   | string | yes      | End date `YYYY-MM-DD` |
| `brand`| string | yes      | Brand name (URL-encoded) |
| `fbs`  | int    | no       | Include FBS (1 = yes) |

**Body:** See `pagination-filter-sort.md`

**Response:** Same product fields as `wb/get/category` (see `wb-categories.md`)

---

### GET wb/get/brand/categories
Get category breakdown for a brand.

**Query params:** `d1`, `d2`, `brand`, `fbs`

---

### GET wb/get/brand/sellers
Get sellers for a brand.

**Query params:** `d1`, `d2`, `brand`, `fbs`

---

### GET wb/get/brand/trends
Get trend data for a brand.

**Query params:** `d1`, `d2`, `brand`, `fbs`

---

### GET wb/get/brand/by_date
Get brand metrics aggregated by day.

**Query params:** `d1`, `d2`, `brand`, `fbs`

---

### GET get/brand/in_warehouses
Get stock breakdown by warehouse for a brand.

**Query params:** `d1`, `d2`, `brand`

---

### GET wb/get/category/price_segmentation
Get price segmentation for a brand (same endpoint, pass brand param).

**Query params:** `d1`, `d2`, `brand`, `fbs`

---

### POST wb/get/brand/compare
Compare two periods for a brand.

**Query params:** `d1`, `d2`, `brand`, `fbs`
**Body:** pagination/filter/sort model

---

### GET wb/get/brand/items
Get subjects (product types/items) for a brand.

**Query params:** `d1`, `d2`, `brand`

---

## Sellers

### POST wb/get/seller
Get products for a seller.

**Query params:**
| Param       | Type   | Required | Description |
|-------------|--------|----------|-------------|
| `d1`        | string | yes      | Start date |
| `d2`        | string | yes      | End date |
| `supplier_id` | int  | yes      | Seller (supplier) ID |
| `fbs`       | int    | no       | Include FBS |

**Body:** See `pagination-filter-sort.md`

**Response:** Same product fields as `wb/get/category`

---

### GET get/seller/categories
Get category breakdown for a seller.

**Query params:** `d1`, `d2`, `supplier_id`, `fbs`

---

### GET wb/get/seller/brands
Get brands for a seller.

**Query params:** `d1`, `d2`, `supplier_id`, `fbs`

---

### GET wb/get/seller/trends
Get trend data for a seller.

**Query params:** `d1`, `d2`, `supplier_id`, `fbs`

---

### GET wb/get/seller/by_date
Get seller metrics by day.

**Query params:** `d1`, `d2`, `supplier_id`, `fbs`

---

### GET get/seller/in_warehouses
Get stock breakdown by warehouse for a seller.

**Query params:** `d1`, `d2`, `supplier_id`

---

### GET wb/get/seller/price_segmentation
Get price segmentation for a seller.

**Query params:** `d1`, `d2`, `supplier_id`, `fbs`

---

### POST wb/get/seller/compare
Compare two periods for a seller.

**Query params:** `d1`, `d2`, `supplier_id`, `fbs`
**Body:** pagination/filter/sort model

---

### GET wb/get/seller/items
Get subjects (product types) for a seller.

**Query params:** `d1`, `d2`, `supplier_id`

---

Use script wrappers:
- `scripts/wb-brand.sh`
- `scripts/wb-seller.sh`

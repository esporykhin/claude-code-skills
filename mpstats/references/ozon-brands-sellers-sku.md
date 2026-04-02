# Ozon — Brands, Sellers & SKU Analytics

All endpoints: `GET` or `POST` to `https://mpstats.io/api/<path>`

---

## Brands

### POST oz/get/brands
Get products for an Ozon brand.

**Query params:**
| Param   | Type   | Required | Description |
|---------|--------|----------|-------------|
| `d1`    | string | yes      | Start date `YYYY-MM-DD` |
| `d2`    | string | yes      | End date `YYYY-MM-DD` |
| `brand` | string | yes      | Brand name (URL-encoded) |
| `fbs`   | int    | no       | Include FBS (1 = yes) |

**Body:** See `pagination-filter-sort.md`

---

### GET oz/get/brand/categories
Get category breakdown for an Ozon brand.

**Query params:** `d1`, `d2`, `brand`, `fbs`

---

### GET oz/get/brand/sellers
Get sellers for an Ozon brand.

**Query params:** `d1`, `d2`, `brand`, `fbs`

---

### GET oz/get/brand/by_date
Get brand metrics by day.

**Query params:** `d1`, `d2`, `brand`, `fbs`

---

### GET oz/get/brand/price_segmentation
Get price segmentation for an Ozon brand.

**Query params:** `d1`, `d2`, `brand`, `fbs`

---

### POST oz/get/brand/compare
Compare two periods for an Ozon brand.

**Query params:** `d1`, `d2`, `brand`, `fbs`
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
| `seller_id` | int    | yes      | Ozon seller ID |
| `fbs`       | int    | no       | Include FBS |

**Body:** See `pagination-filter-sort.md`

---

### GET oz/get/seller/categories
Get category breakdown for an Ozon seller.

**Query params:** `d1`, `d2`, `seller_id`, `fbs`

---

### GET oz/get/seller/brands
Get brands for an Ozon seller.

**Query params:** `d1`, `d2`, `seller_id`, `fbs`

---

### GET oz/get/seller/by_date
Get seller metrics by day.

**Query params:** `d1`, `d2`, `seller_id`, `fbs`

---

### GET oz/get/seller/price_segmentation
Get price segmentation for an Ozon seller.

**Query params:** `d1`, `d2`, `seller_id`, `fbs`

---

### POST oz/get/seller/compare
Compare two periods for an Ozon seller.

**Query params:** `d1`, `d2`, `seller_id`, `fbs`
**Body:** pagination/filter/sort model

---

## SKU-Level Analytics

### GET oz/get/item/{sku}/sales
Get sales and stock history for an Ozon SKU.

```bash
curl --location --request GET \
  'https://mpstats.io/api/oz/get/item/123456789/sales' \
  --header 'X-Mpstats-TOKEN: YOUR_TOKEN' \
  --header 'Content-Type: application/json'
```

---

Use script wrappers:
- `scripts/ozon-brand.sh`
- `scripts/ozon-seller.sh`
- `scripts/ozon-sku.sh`

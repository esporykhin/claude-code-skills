# Wildberries — Similar Products & SKU Analytics

All endpoints: `GET` or `POST` to `https://mpstats.io/api/<path>`

---

## Similar Products (AI-based)

### POST wb/get/identical
Get AI-similar products for a given product.

**Query params:** `d1`, `d2`, SKU identifier, `fbs`
**Body:** pagination/filter/sort model

### GET wb/get/identical/categories
Get categories for AI-similar products.

### GET wb/get/identicial/brands
Get brands for AI-similar products.

### GET wb/get/identicial/sellers
Get sellers for AI-similar products.

### GET wb/get/identicial/price_segmentation
Get price segmentation for AI-similar products.

---

## Similar Products (WB-based)

### POST wb/get/similar
Get WB-similar products for a given product.

**Query params:** `d1`, `d2`, SKU identifier, `fbs`
**Body:** pagination/filter/sort model

### GET wb/get/similar/categories
Get categories for WB-similar products.

### GET wb/get/similar/brands
Get brands for WB-similar products.

### GET wb/get/similar/sellers
Get sellers for WB-similar products.

### GET wb/get/similar/price_segmentation
Get price segmentation for WB-similar products.

---

## In Similar Products (reverse)

### GET wb/get/in_similar
Get products where the given product appears as "similar".

### GET wb/get/in_similar/categories
Get categories where the given product appears as similar.

### GET wb/get/in_similar/brands
Get brands where the given product appears as similar.

### GET wb/get/in_similar/sellers
Get sellers where the given product appears as similar.

### GET wb/get/in_similar/price_segmentation
Get price segmentation for in-similar products.

---

## SKU-Level Analytics

All endpoints use `{sku}` as the WB product ID (numeric).

### GET wb/get/item/{sku}/sales
Get sales and stock history for a SKU.

```bash
curl --location --request GET \
  'https://mpstats.io/api/wb/get/item/152490541/sales' \
  --header 'X-Mpstats-TOKEN: YOUR_TOKEN' \
  --header 'Content-Type: application/json'
```

---

### GET wb/get/item/{sku}/balance_by_day
Get daily sales and stock balance for a SKU.

---

### GET wb/get/item/{sku}/balance_by_region
Get current stock breakdown by region/warehouse for a SKU.

---

### GET wb/get/item/{sku}/balance_by_size
Get current stock breakdown by size for a SKU.

---

### GET wb/get/item/{sku}/sales_by_region
Get sales breakdown by region for a SKU.

---

### GET wb/get/item/{sku}/sales_by_size
Get sales breakdown by size for a SKU.

---

## SKU Similar Products

### GET wb/get/item/{SKU}/identical
Get AI-similar products for a SKU.

### GET wb/get/item/{SKU}/identical_wb
Get WB AI-similar products for a SKU.

### GET wb/get/item/{SKU}/similar
Get WB-similar products for a SKU.

### GET wb/get/item/{SKU}/in_similar
Get products that list this SKU as similar.

---

## SKU Category & Keyword Positions

### GET wb/get/item/{sku}/by_category
Get categories the SKU appears in and its position in each.

**Response item fields:**
| Field | Description |
|-------|-------------|
| `category` | Category path |
| `position` | Position in category |
| `date` | Date |

---

### GET wb/get/item/{sku}/by_keywords
Get search queries the SKU appears in and its position for each.

**Response item fields:**
| Field | Description |
|-------|-------------|
| `keyword` | Search query |
| `position` | Position in search results |
| `date` | Date |

---

## SKU Card History

### GET wb/get/item/{SKU}/full_page/versions
Get list of product card versions (change history).

**Response item fields:**
| Field | Description |
|-------|-------------|
| `version` | Version hash |
| `date` | Date of version |

---

### GET wb/get/item/{SKU}/full_page?version={version_hash}
Get product card data for a specific version.

**Query params:**
| Param     | Type   | Description |
|-----------|--------|-------------|
| `version` | string | Version hash from versions endpoint |

---

## SKU Reviews History

### GET wb/get/item/{SKU}/comments
Get review history for a SKU.

**Response item fields:**
| Field | Description |
|-------|-------------|
| `date` | Review date |
| `text` | Review text |
| `rating` | Rating (1–5) |
| `valuation` | Valuation score |

---

## Example: Monitor SKU Sales (TypeScript)

```typescript
async function getSkuSales(sku: number, token: string) {
  const res = await fetch(
    `https://mpstats.io/api/wb/get/item/${sku}/sales`,
    {
      headers: {
        'X-Mpstats-TOKEN': token,
        'Content-Type': 'application/json',
      },
    }
  );
  if (!res.ok) throw new Error(`API error: ${res.status}`);
  return res.json();
}

async function getSkuStockByWarehouse(sku: number, token: string) {
  const res = await fetch(
    `https://mpstats.io/api/wb/get/item/${sku}/balance_by_region`,
    {
      headers: {
        'X-Mpstats-TOKEN': token,
        'Content-Type': 'application/json',
      },
    }
  );
  return res.json();
}
```

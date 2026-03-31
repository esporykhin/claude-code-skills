---
name: mpstats
version: 1.0.0
description: "MPSTATS marketplace analytics API. Use when working with MPSTATS API, Wildberries analytics, Ozon analytics, Yandex Market analytics, marketplace data, product research, sales analytics, competitor analysis, niche research, SKU analysis, seller analytics, brand analytics."
license: MIT
metadata:
  author: esporykhin
  version: "1.0.0"
---

# MPSTATS API

MPSTATS is a Russian marketplace analytics platform providing data on Wildberries, Ozon, and Yandex Market. The API allows integrating marketplace analytics into your own projects: product research, category analysis, seller/brand monitoring, SKU-level sales data.

## When to Apply

- Working with MPSTATS API endpoints
- Fetching marketplace data (WB, Ozon, YM)
- Building analytics tools for Russian marketplaces
- Product/niche/seller/brand research via API
- SKU-level sales, stock, and review data
- Category subcategory breakdown, price segmentation
- Competitor analysis via marketplace data

## Base URL & Auth

```
Base URL: https://mpstats.io/api/
```

**Authentication:** Personal token required for every request.

Header method (preferred):
```
X-Mpstats-TOKEN: <your_token>
```

Query param alternative:
```
?auth-token=<your_token>
```

Token is generated in account settings at https://mpstats.io/userpanel (API token block). Token is reset on password change or manual regeneration.

**Content-Type:** Always send `Content-Type: application/json`

## Response Codes

| Code | Meaning |
|------|---------|
| 200  | Success |
| 202  | Accepted but not yet complete — retry later |
| 401  | Authorization error |
| 429  | Rate limit exceeded — check `message` field and `Retry-After` header (seconds) |
| 500  | Internal server error — check `message` field |

## Quick Reference

### Wildberries API
See `references/wb-categories.md` — category rubricator, category products, subcategories, brands, sellers, trends, by-date, price segmentation, period comparison, subjects, AI forecasts, seasonal effects

See `references/wb-brands-sellers.md` — brand analytics (products, categories, sellers, by-date, warehouses, price segmentation, period comparison, items), seller analytics (same set)

See `references/wb-similar-sku.md` — similar products (AI, WB AI, WB), in-similar products, SKU-level data (sales, balance, regions, sizes), product card history, reviews history

### Ozon API
See `references/ozon-categories.md` — category rubricator, category products, subcategories, brands, sellers, by-date, price segmentation, period comparison

See `references/ozon-brands-sellers-sku.md` — brand analytics, seller analytics, SKU sales data

### Yandex Market API
See `references/ym-categories.md` — category products, subcategories, sellers, brands, by-date, price segmentation, period comparison

See `references/ym-brands-sellers-sku.md` — brand analytics, seller analytics, SKU sales data

### Pagination, Filtering & Sorting
See `references/pagination-filter-sort.md` — common request/response model used by all POST endpoints

### Code Examples
See `references/code-examples.md` — TypeScript and Python examples

### Account API
See `references/account.md` — API limits remaining

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

### Account API
See `references/account.md` — API limits remaining

## Scripts

Ready-to-use shell scripts in `scripts/` directory. Call via Bash tool instead of writing code.

All scripts require `MPSTATS_TOKEN` in environment for each run.

If token is missing, ask user to provide MPSTATS token directly in chat and run script with temporary env var (`MPSTATS_TOKEN=<token> ...`).

| Script | Purpose | Usage |
|--------|---------|-------|
| `account-limits.sh` | Check API quota remaining | `./scripts/account-limits.sh` |
| `wb-categories-list.sh` | Full WB category tree | `./scripts/wb-categories-list.sh` |
| `wb-category.sh` | WB category products | `./scripts/wb-category.sh "Электроника/Смартфоны" 2024-01-01 2024-03-01` |
| `wb-category-stats.sh` | WB category breakdown (subcategories/brands/sellers/trends) | `./scripts/wb-category-stats.sh "Электроника" subcategories` |
| `wb-sku.sh` | WB SKU analytics (sales/balance/positions/reviews) | `./scripts/wb-sku.sh 152490541 sales` |
| `wb-brand.sh` | WB brand products or analytics | `./scripts/wb-brand.sh "Nike" products` |
| `wb-seller.sh` | WB seller products or analytics | `./scripts/wb-seller.sh 123456 products` |
| `wb-search.sh` | WB subjects/niches list for research | `./scripts/wb-search.sh` |
| `ozon-categories-list.sh` | Full Ozon category tree | `./scripts/ozon-categories-list.sh` |
| `ozon-category.sh` | Ozon category products or stats | `./scripts/ozon-category.sh "Автотовары" products` |
| `ozon-sku.sh` | Ozon SKU sales history | `./scripts/ozon-sku.sh 123456789` |
| `ozon-brand.sh` | Ozon brand products or analytics | `./scripts/ozon-brand.sh "Samsung"` |
| `ozon-seller.sh` | Ozon seller products or analytics | `./scripts/ozon-seller.sh 987654` |
| `ym-category.sh` | Yandex Market category products or stats | `./scripts/ym-category.sh "Электроника/Смартфоны"` |
| `ym-sku.sh` | Yandex Market item sales history | `./scripts/ym-sku.sh 12345678` |

Run any script with `--help` for full parameter reference.

### When to use which script

- User asks about a **product/SKU** on WB → `wb-sku.sh <sku> sales`
- User asks about a **product/SKU** on Ozon → `ozon-sku.sh <sku>`
- User asks about a **product/SKU** on YM → `ym-sku.sh <id>`
- User asks about a **WB category** (products, revenue, top sellers) → `wb-category.sh`
- User asks for **subcategory/brand/seller breakdown** within WB category → `wb-category-stats.sh`
- User asks about an **Ozon category** → `ozon-category.sh`
- User asks about a **YM category** → `ym-category.sh`
- User asks about a **brand** on WB → `wb-brand.sh`
- User asks about a **brand** on Ozon → `ozon-brand.sh`
- User asks about a **seller** on WB → `wb-seller.sh`
- User asks about a **seller** on Ozon → `ozon-seller.sh`
- Need to find available **niches/subjects** on WB → `wb-search.sh`
- Need to check **API limits** → `account-limits.sh`
- Need full **category tree** → `wb-categories-list.sh` or `ozon-categories-list.sh`

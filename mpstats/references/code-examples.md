# Code Examples

Complete working examples for MPSTATS API integration.

---

## TypeScript / Node.js

### Setup

```typescript
const BASE_URL = 'https://mpstats.io/api';
const TOKEN = process.env.MPSTATS_TOKEN!;

const defaultHeaders = {
  'X-Mpstats-TOKEN': TOKEN,
  'Content-Type': 'application/json',
};

async function get(path: string) {
  const res = await fetch(`${BASE_URL}/${path}`, { headers: defaultHeaders });
  if (res.status === 429) {
    const retryAfter = res.headers.get('Retry-After') || '60';
    throw new Error(`Rate limited. Retry after ${retryAfter}s`);
  }
  if (!res.ok) throw new Error(`MPSTATS error: ${res.status}`);
  return res.json();
}

async function post(path: string, params: Record<string, string>, body: object) {
  const qs = new URLSearchParams(params).toString();
  const res = await fetch(`${BASE_URL}/${path}?${qs}`, {
    method: 'POST',
    headers: defaultHeaders,
    body: JSON.stringify(body),
  });
  if (res.status === 429) {
    const retryAfter = res.headers.get('Retry-After') || '60';
    throw new Error(`Rate limited. Retry after ${retryAfter}s`);
  }
  if (!res.ok) throw new Error(`MPSTATS error: ${res.status}`);
  return res.json();
}
```

### Fetch WB category products with pagination

```typescript
async function fetchWbCategory(categoryPath: string, d1: string, d2: string) {
  const pageSize = 5000;
  let startRow = 0;
  let total = Infinity;
  const products: any[] = [];

  while (startRow < total) {
    const data = await post('wb/get/category', { d1, d2, path: categoryPath }, {
      startRow,
      endRow: startRow + pageSize,
      filterModel: {},
      sortModel: [{ colId: 'revenue', sort: 'desc' }],
    });
    total = data.total;
    products.push(...data.data);
    startRow += pageSize;
  }

  return products;
}

// Usage
const dresses = await fetchWbCategory('Женщинам/Платья и сарафаны', '2024-01-01', '2024-01-31');
console.log(`Total products: ${dresses.length}`);
console.log(`Top revenue: ${dresses[0]?.revenue}`);
```

### Niche analysis: top products in category

```typescript
async function analyzeNiche(categoryPath: string, d1: string, d2: string) {
  const [products, subcategories, brands] = await Promise.all([
    post('wb/get/category', { d1, d2, path: categoryPath }, {
      startRow: 0,
      endRow: 100,
      filterModel: {},
      sortModel: [{ colId: 'revenue', sort: 'desc' }],
    }),
    get(`wb/get/category/subcategories?d1=${d1}&d2=${d2}&path=${encodeURIComponent(categoryPath)}`),
    get(`wb/get/category/brands?d1=${d1}&d2=${d2}&path=${encodeURIComponent(categoryPath)}`),
  ]);

  return {
    topProducts: products.data.slice(0, 10),
    subcategories,
    brands,
  };
}
```

### SKU monitoring

```typescript
async function monitorSku(sku: number) {
  const [sales, stockByRegion, stockBySize] = await Promise.all([
    get(`wb/get/item/${sku}/sales`),
    get(`wb/get/item/${sku}/balance_by_region`),
    get(`wb/get/item/${sku}/balance_by_size`),
  ]);

  return { sales, stockByRegion, stockBySize };
}
```

### Handle 429 with retry

```typescript
async function fetchWithRetry(url: string, options: RequestInit, maxRetries = 3) {
  for (let attempt = 0; attempt < maxRetries; attempt++) {
    const res = await fetch(url, options);

    if (res.status === 429) {
      const retryAfter = parseInt(res.headers.get('Retry-After') || '60', 10);
      if (attempt < maxRetries - 1) {
        await new Promise(resolve => setTimeout(resolve, retryAfter * 1000));
        continue;
      }
    }

    if (!res.ok) throw new Error(`HTTP ${res.status}`);
    return res.json();
  }
  throw new Error('Max retries exceeded');
}
```

---

## Python

### Setup

```python
import requests
from urllib.parse import urlencode, quote
import time

BASE_URL = "https://mpstats.io/api"

class MPStatsClient:
    def __init__(self, token: str):
        self.token = token
        self.session = requests.Session()
        self.session.headers.update({
            "X-Mpstats-TOKEN": token,
            "Content-Type": "application/json",
        })

    def get(self, path: str, params: dict = None):
        resp = self.session.get(f"{BASE_URL}/{path}", params=params)
        if resp.status_code == 429:
            retry_after = int(resp.headers.get("Retry-After", 60))
            raise Exception(f"Rate limited. Retry after {retry_after}s")
        resp.raise_for_status()
        return resp.json()

    def post(self, path: str, params: dict, body: dict):
        resp = self.session.post(f"{BASE_URL}/{path}", params=params, json=body)
        if resp.status_code == 429:
            retry_after = int(resp.headers.get("Retry-After", 60))
            raise Exception(f"Rate limited. Retry after {retry_after}s")
        resp.raise_for_status()
        return resp.json()

    def post_all_pages(self, path: str, params: dict, filters: dict = None):
        """Fetch all pages from a paginated POST endpoint."""
        page_size = 5000
        start_row = 0
        total = float("inf")
        all_data = []

        while start_row < total:
            data = self.post(path, params, {
                "startRow": start_row,
                "endRow": start_row + page_size,
                "filterModel": filters or {},
                "sortModel": [],
            })
            total = data["total"]
            all_data.extend(data["data"])
            start_row += page_size

        return all_data
```

### WB category analysis

```python
client = MPStatsClient(token="YOUR_TOKEN")

# Get all products in category
products = client.post_all_pages(
    "wb/get/category",
    params={"d1": "2024-01-01", "d2": "2024-01-31", "path": "Женщинам/Платья и сарафаны"},
)

# Get subcategories
subcats = client.get(
    "wb/get/category/subcategories",
    params={"d1": "2024-01-01", "d2": "2024-01-31", "path": "Женщинам/Платья и сарафаны"},
)

# Summary
total_revenue = sum(p["revenue"] for p in products)
avg_price = sum(p["final_price"] for p in products) / len(products)
print(f"Products: {len(products)}, Total Revenue: {total_revenue:,.0f}₽, Avg Price: {avg_price:.0f}₽")
```

### Check API limits

```python
limits = client.get("user/report_api_limit")
remaining = limits["available"] - limits["use"]
print(f"API calls remaining: {remaining} / {limits['available']}")
```

### SKU analysis

```python
sku = 152490541

sales = client.get(f"wb/get/item/{sku}/sales")
by_region = client.get(f"wb/get/item/{sku}/balance_by_region")
categories = client.get(f"wb/get/item/{sku}/by_category")

print(f"Sales data points: {len(sales)}")
print(f"Regions: {len(by_region)}")
print(f"Categories: {len(categories)}")
```

---

## cURL Examples

### Get WB rubricator
```bash
curl --location --request GET 'https://mpstats.io/api/wb/get/categories' \
  --header 'X-Mpstats-TOKEN: YOUR_TOKEN' \
  --header 'Content-Type: application/json'
```

### Get WB category products
```bash
curl --location --request POST \
  'https://mpstats.io/api/wb/get/category?d1=2024-01-01&d2=2024-01-31&path=%D0%96%D0%B5%D0%BD%D1%89%D0%B8%D0%BD%D0%B0%D0%BC/%D0%9E%D0%B4%D0%B5%D0%B6%D0%B4%D0%B0' \
  --header 'X-Mpstats-TOKEN: YOUR_TOKEN' \
  --header 'Content-Type: application/json' \
  --data-raw '{"startRow":0,"endRow":100,"filterModel":{},"sortModel":[{"colId":"revenue","sort":"desc"}]}'
```

### Get Ozon rubricator
```bash
curl --location --request GET 'https://mpstats.io/api/oz/get/categories' \
  --header 'X-Mpstats-TOKEN: YOUR_TOKEN' \
  --header 'Content-Type: application/json'
```

### Get SKU sales (WB)
```bash
curl --location --request GET 'https://mpstats.io/api/wb/get/item/152490541/sales' \
  --header 'X-Mpstats-TOKEN: YOUR_TOKEN' \
  --header 'Content-Type: application/json'
```

### Check API limit
```bash
curl --location --request GET 'https://mpstats.io/api/user/report_api_limit' \
  --header 'X-Mpstats-TOKEN: YOUR_TOKEN' \
  --header 'Content-Type: application/json'
```

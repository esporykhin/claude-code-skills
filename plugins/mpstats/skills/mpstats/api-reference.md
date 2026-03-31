# MPSTATS REST API Reference

Base URL: `https://mpstats.io/api/v1`

## Authentication

Every request must include:
```
X-Mpstats-TOKEN: <your_api_token>
```

Get token at: https://mpstats.io/profile/api

## Wildberries Endpoints

### Subject (Niche) Data

```
GET /wb/get/subject/{subject}
```

Parameters:
- `subject` (path) — subjectId or subject name
- `d1` (query) — start date `YYYY-MM-DD`
- `d2` (query) — end date `YYYY-MM-DD`

Response:
```json
{
  "id": 105,
  "name": "Кроссовки мужские",
  "groupname": "Обувь",
  "revenue": 1250000000,
  "orders": 45000,
  "items_count": 12500,
  "brands_count": 340,
  "sellers_count": 890,
  "avg_price": 3200,
  "lost_proceeds": 45000000
}
```

### Search Subjects by Keyword

```
GET /wb/get/keyword/subjects
```

Parameters:
- `keyword` — search term (Russian)
- `d1`, `d2` — date range

### Product (Item) Data

```
GET /wb/get/item/{nmId}
```

Parameters:
- `nmId` (path) — WB product identifier
- `d1`, `d2` — date range

Response includes: `revenue`, `orders`, `price`, `rating`, `reviews_count`, `seller_id`, `brand`, `category`

### Seller Data

```
GET /wb/get/seller/{sellerId}
```

Parameters:
- `sellerId` (path) — WB seller identifier
- `d1`, `d2` — date range

### Keywords for a Subject

```
GET /wb/get/keywords
```

Parameters:
- `subject_id` — subject identifier
- `d1`, `d2` — date range

Response: array of `{ keyword, frequency, wb_search_count, ads_count }`

### Category Tree

```
GET /wb/get/categories
```

Returns full WB category tree: parent → group → subject

## Ozon Endpoints

Same structure as WB, replace `/wb/` with `/oz/`:

```
GET /oz/get/subject/{subject}
GET /oz/get/item/{sku}
GET /oz/get/seller/{sellerId}
GET /oz/get/keywords
```

## Rate Limits

| Plan | Requests/minute | Requests/day |
|------|----------------|--------------|
| Free | 5 | 100 |
| Basic | 60 | 5,000 |
| Pro | 300 | 50,000 |
| Enterprise | Unlimited | Unlimited |

## Error Codes

| HTTP Status | Meaning |
|-------------|---------|
| 400 | Bad request — check parameters |
| 401 | Invalid or missing token |
| 403 | Plan limit exceeded |
| 404 | Subject/item not found |
| 429 | Rate limit exceeded |
| 500 | Server error — retry with backoff |

## Pagination

List endpoints use cursor-based pagination:

```
GET /wb/get/seller/{sellerId}/items?d1=2024-01-01&d2=2024-01-31&cursor=next_page_token
```

Response includes `next_cursor` when more pages exist.

## TypeScript Types

```typescript
interface SubjectStats {
  id: number;
  name: string;
  groupname: string;
  parent_name?: string;
  revenue: number;
  revenue_median: number;
  revenue_per_item: number;
  orders: number;
  orders_per_item: number;
  items_count: number;
  brands_count: number;
  sellers_count: number;
  avg_price: number;
  price_range_low: number;
  price_range_high: number;
  lost_proceeds: number;
}

interface ItemStats {
  id: number;           // nmId
  name: string;
  brand: string;
  seller_id: number;
  subject_id: number;
  revenue: number;
  orders: number;
  price: number;
  rating: number;
  reviews_count: number;
  in_stock: boolean;
  photos: string[];
}

interface KeywordStats {
  keyword: string;
  frequency: number;
  wb_search_count: number;
  ads_count: number;
  cpm: number;
}

type MpstatsApiError = {
  error: string;
  message: string;
  status: number;
};
```

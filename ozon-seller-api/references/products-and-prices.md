# Products and Prices

## Product List

Endpoint:

```text
POST /v2/product/list
```

Script:

```bash
./scripts/products-list.sh [visibility] [limit] [last_id] [offer_ids_csv] [product_ids_csv]
```

Key fields:

- `filter.visibility`
- `filter.offer_id[]`
- `filter.product_id[]`
- `limit`
- `last_id`

## Product Prices

Endpoint:

```text
POST /v4/product/info/prices
```

Script:

```bash
./scripts/product-prices.sh [visibility] [limit] [last_id] [offer_ids_csv] [product_ids_csv]
```

From documentation contract:

- Up to `1000` products per request.

Useful response fields:

- `result.items[]` — prices and related product info
- `result.last_id` — cursor for next page
- `result.total` — total matching products

## Update Stocks

Endpoint:

```text
POST /v1/product/import/stocks
```

Script:

```bash
./scripts/update-stocks.sh --file payload.json
./scripts/update-stocks.sh <offer_id> <stock> [product_id]
```

From documentation contract:

- Method is for FBS/rFBS stock updates.
- Up to `100` items per request.
- Up to `80` requests per minute.

Payload shape:

```json
{
  "stocks": [
    {
      "offer_id": "SKU-123",
      "stock": 15,
      "product_id": 123456789
    }
  ]
}
```

## Update Prices

Endpoint:

```text
POST /v1/product/import/prices
```

Script:

```bash
./scripts/update-prices.sh --file payload.json
./scripts/update-prices.sh <offer_id> <price> [old_price] [currency_code] [min_price] [product_id]
```

From documentation contract:

- Up to `1000` items per request.
- To reset `old_price` / `premium_price`, set them to `0`.
- Price update should satisfy Ozon validation rules (for example minimum delta constraints).

Payload shape:

```json
{
  "prices": [
    {
      "offer_id": "SKU-123",
      "price": "1299",
      "old_price": "1599",
      "currency_code": "RUB"
    }
  ]
}
```

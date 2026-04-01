# Postings, Reports, Warehouses

## FBS Postings List

Endpoint:

```text
POST /v3/posting/fbs/list
```

Script:

```bash
./scripts/postings-fbs-list.sh [since] [to] [status] [limit] [offset]
```

Notes from method description:

- Time range can be requested up to one year.
- If `has_next = true`, fetch the next page with updated `offset`.

## FBO Postings List

Endpoint:

```text
POST /v2/posting/fbo/list
```

Script:

```bash
./scripts/postings-fbo-list.sh [since] [to] [status] [limit] [offset]
```

## Warehouses

Endpoint:

```text
POST /v1/warehouse/list
```

Script:

```bash
./scripts/warehouses-list.sh
```

Request body:

```json
{}
```

## Reports

List reports endpoint:

```text
POST /v1/report/list
```

Details endpoint:

```text
POST /v1/report/info
```

Scripts:

```bash
./scripts/report-list.sh [report_type] [page] [page_size]
./scripts/report-info.sh <code>
```

Workflow:

1. Call `report-list.sh` to get report metadata and `code`.
2. Call `report-info.sh <code>` to get status and file/link details.

## Raw Requests

For methods not covered by specialized scripts, use:

```bash
./scripts/request-raw.sh <METHOD> <endpoint> [payload_file]
```

Examples:

```bash
./scripts/request-raw.sh GET /v1/actions
./scripts/request-raw.sh POST /v2/product/list payload.json
```

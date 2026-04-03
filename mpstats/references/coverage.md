# MPSTATS Coverage Status

This file tracks script coverage against endpoints documented in `references/*.md`.

## Short answer

Yes: all documented methods are now invocable via scripts.

## How coverage is implemented

1. Dedicated wrappers for major families:
- Account: `scripts/account/account-limits.sh`
- Wildberries: `scripts/wb/*.sh` including subject/similar/analytics/compare/warehouses/promotion
- Ozon: `scripts/ozon/*.sh` including compare
- Yandex Market: `scripts/ym/*.sh` including compare

2. Universal fallback for any endpoint:
- `scripts/request.sh <METHOD> <path> [query] [body_json]`
- This guarantees access even when a dedicated wrapper is not the preferred route.

## Notes

- References remain the source-of-truth for exact endpoint contracts.
- Dedicated wrappers are optimized for common analytical flows.
- Use `scripts/README.md` for "what script to run and when".
- WB `wb/get/subject/geography` is temporarily disabled in `scripts/wb/wb-subject.sh` due to unstable API-side `500` responses (`"Некорректный формат даты"`).

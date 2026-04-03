# Free Checker Mapping

Цель: повторить поведение `https://loocl.ru/tools/position-checker` и отправлять запрос напрямую в его endpoint.

## Что вводит пользователь в free checker

- `organization` — ссылка на карточку Яндекс или ID
- `queries` — список запросов (до 5 в UI)
- `coordinates.lat`, `coordinates.lon`
- `radiusKm`

## Во что уходит запрос

| Free checker input | Endpoint field |
|---|---|
| `organization` (ID) | `targetOrgId` |
| `organization` (URL карточки с ID) | `targetOrgId` (ID извлекается из URL) |
| `organization` (другой URL) | `targetOrgUrl` |
| `queries[]` | `queries[]` |
| `coordinates.lat` | `coordinates.lat` |
| `coordinates.lon` | `coordinates.lon` |
| `radiusKm` | `radiusKm` |

## Совместимость скрипта `check-position-free.sh`

Скрипт принимает `radius_meters` для удобства и конвертирует в `radiusKm`:

- `radiusKm = radius_meters / 1000`

`organization_name` принимается как совместимый параметр, но в endpoint не отправляется.

Также можно передавать локацию как:

- `lat lon` (старый формат)
- `lat,lon`
- адрес строкой (геокодируется в координаты)

## Готовый скрипт

```bash
./scripts/check-position-free.sh \
  "https://yandex.ru/maps/org/pilim_lyubim/188841488618/" \
  "маникюр,педикюр,ногти" \
  "Москва, Тверская 7" \
  2000 \
  "Пилим Любим"
```

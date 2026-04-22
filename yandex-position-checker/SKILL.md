---
name: yandex-position-checker
version: 1.0.0
description: "Yandex Maps position checker via public endpoint. Use when checking card positions on Yandex Maps, local SERP visibility, geo-dependent ranking, or reproducing free checker logic from loocl.ru/tools/position-checker."
license: MIT
metadata:
  author: esporykhin
  version: "1.0.0"
---

# Yandex Position Checker

Скилл для проверки позиций карточки организации в Яндекс Картах через endpoint `POST /api/tools/check-positions`.

Основной endpoint: `POST /api/tools/check-positions`.

## When to Apply

- Нужно проверить позицию карточки в Яндекс Картах по ключевым запросам
- Нужно повторить логику бесплатного чекера с `https://loocl.ru/tools/position-checker`
- Нужно быстро сделать разовую/пакетную проверку локальной выдачи
- Нужно сравнить позиции при разных координатах/радиусах

## Base URL

По умолчанию скрипты используют:

```bash
https://loocl.ru
```

Переопредели через env:

```bash
YANDEX_POSITION_CHECKER_BASE_URL=https://your-domain
```

Также значение может быть задано в `config/.env` внутри скилла (см. [config/README.md](config/README.md)).
Для обратной совместимости поддерживается и `LOOCL_BASE_URL`.

Если `config/.env` нет и хочешь что-то переопределить — агент может спросить значения у пользователя и предложить два варианта: кинуть в чат (агент создаст `config/.env` сам) или скопировать `config/.env.example` вручную.

## Endpoint Summary

`POST /api/tools/check-positions`

Ключевые поля запроса:
- `queries[]` (в UI free checker используется до 5)
- `targetOrgId` или `targetOrgUrl`
- `coordinates.lat`, `coordinates.lon`
- `radiusKm`

Координаты можно передавать тремя способами:
- явно (`lat`, `lon`)
- строкой адреса (геокодирование в координаты)
- строкой `lat,lon`

Логика target как в free checker:
- если строка состоит только из цифр -> `targetOrgId`
- если это URL карточки `.../org/.../<id>` -> `targetOrgId`
- иначе, если это URL -> `targetOrgUrl`
- иначе -> `targetOrgId`

Подробнее: `references/endpoint-check-positions.md`

## Free Checker Mapping

Бесплатный чекер (`/tools/position-checker`) отправляет:
- `queries`
- `targetOrgId` или `targetOrgUrl`
- `coordinates`
- `radiusKm`

Скрипт `check-position-free.sh` поддерживает совместимый формат (radius в метрах) и маппит в контракт endpoint.

Подробнее: `references/free-checker-mapping.md`

## Scripts

Готовые shell-скрипты в `scripts/`.

| Script | Purpose | Usage |
|--------|---------|-------|
| `check-position.sh` | Универсальная проверка позиции (URL/ID + запросы) | `./scripts/check-position.sh "https://yandex.ru/maps/org/..." "барбершоп,мужская стрижка" 55.75 37.61 2` |
| `check-position-free.sh` | Совместимый с free-checker формат (organization + keywords + radius в метрах) | `./scripts/check-position-free.sh "https://yandex.ru/maps/org/..." "барбершоп,мужская стрижка" "Москва, Тверская 7" 2000` |
| `check-position-raw.sh` | Отправка сырого JSON в `check-positions` | `./scripts/check-position-raw.sh '{"queries":["барбершоп"],"targetOrgId":"123"}'` |

## Which Script to Use

- У тебя есть URL/ID карточки + список запросов -> `check-position.sh`
- Нужно повторить формат бесплатного чекера (радиус в метрах) -> `check-position-free.sh`
- Нужен полный контроль над JSON запроса -> `check-position-raw.sh`

### Location Resolution Notes

- `check-position.sh`:
- старый формат: `<lat> <lon> [radius_km]`
- новый формат: `<location|lat,lon> [radius_km]`
- `check-position-free.sh`:
- старый формат: `<lat> <lon> [radius_meters] [organization_name]`
- новый формат: `<location|lat,lon|address> [radius_meters] [organization_name]`
- Если задан `YANDEX_GEOCODER_API_KEY`, адреса сначала пробуются через Yandex Geocoder, иначе используется Nominatim (OpenStreetMap).

### Agent Instruction for Address Checks

- Если пользователь хочет проверять позиции по конкретным адресам, агент должен попросить `YANDEX_GEOCODER_API_KEY` и использовать его в вызовах.
- Предпочтительный сценарий для адресов: `YANDEX_GEOCODER_API_KEY` установлен + адрес передается строкой в `check-position.sh` / `check-position-free.sh`.
- Если ключ не предоставлен, агент может использовать fallback-геокодирование, но должен явно предупредить пользователя, что для точности по РФ лучше ключ Яндекс Геокодера.

# Endpoint: /api/tools/check-positions

Источник: фронтенд бесплатного чекера `https://loocl.ru/tools/position-checker`.

Запрос в коде страницы:
- `fetch("/api/tools/check-positions", { method: "POST", ... })`
- Body: `JSON.stringify({ queries, ...target, coordinates, radiusKm })`

Итоговый URL:
- `POST /api/tools/check-positions`

## Request

Минимально:

```json
{
  "queries": ["барбершоп"],
  "targetOrgId": "123456789"
}
```

Расширенный пример:

```json
{
  "queries": ["барбершоп", "мужская стрижка"],
  "targetOrgId": "123456789",
  "coordinates": {
    "lat": 55.7558,
    "lon": 37.6176
  },
  "radiusKm": 2
}
```

## Target Normalization (как во free checker)

Из строки `organization` формируется `target`:

- `^\d+$` -> `{ "targetOrgId": "..." }`
- URL формата `.../org/.../<id>` -> `{ "targetOrgId": "<id>" }`
- Любой URL, начинающийся с `http` -> `{ "targetOrgUrl": "..." }`
- Иначе -> `{ "targetOrgId": "..." }`

## Frontend Validation (free checker)

- `queries`: минимум 1 запрос
- `queries`: в UI используется не больше 5 (`slice(0, 5)`)
- `organization`: обязательное поле
- `coordinates`: обязательное поле (точка выбирается на карте)
- `radiusKm`: передается из слайдера радиуса

## Location Resolution in Skill Scripts

Скрипты скилла поддерживают ввод локации в удобном формате:

- `lat lon` (старый режим)
- `lat,lon` (одной строкой)
- адрес (например, `Москва, Тверская 7`)

Геокодирование адреса:

- если есть `YANDEX_GEOCODER_API_KEY` -> сначала Yandex Geocoder
- fallback -> Nominatim (OpenStreetMap)

## Response (ожидаемая структура)

```json
{
  "results": [
    {
      "query": "барбершоп",
      "primaryPosition": 11,
      "primaryPositionSource": "maps",
      "cards": [
        {
          "position": 1,
          "title": "Организация",
          "rating": 4.9,
          "reviewsCount": 120,
          "category": "Барбершоп",
          "address": "Москва, ..."
        }
      ]
    }
  ]
}
```

Ключевое поле ранга в UI: `results[].primaryPosition`.

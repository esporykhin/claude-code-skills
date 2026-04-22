# Companies API (Компании)

Base: `https://{subdomain}.amocrm.ru/api/v4/companies`

## Endpoints

| Method | Path | Purpose |
|--------|------|---------|
| GET | `/api/v4/companies` | Список компаний |
| GET | `/api/v4/companies/{id}` | Одна компания |
| POST | `/api/v4/companies` | Пакетное создание |
| PATCH | `/api/v4/companies` | Пакетное редактирование |
| PATCH | `/api/v4/companies/{id}` | Одной |

## Query (GET)

- `with`: `catalog_elements`, `leads`, `customers`, `contacts`
- `page`, `limit` (≤250), `query`, `filter[...]`, `order[...]`

## Ключевые поля

- `name` — название
- `responsible_user_id`
- `created_at` / `updated_at` (unix)
- `custom_fields_values` — `PHONE`, `EMAIL`, `WEB`, `ADDRESS` через `field_code`
- `_embedded.tags`, `_embedded.contacts` (`[{id}]`)

## Пример

```bash
POST /api/v4/companies
[
  {
    "name": "ООО Ромашка",
    "custom_fields_values": [
      {"field_code": "PHONE", "values": [{"value": "+74950000000", "enum_code": "WORK"}]},
      {"field_code": "WEB",   "values": [{"value": "https://romashka.ru"}]}
    ]
  }
]
```

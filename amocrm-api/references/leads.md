# Leads API (Сделки)

Base: `https://{subdomain}.amocrm.ru/api/v4/leads`

## Endpoints

| Method | Path | Purpose |
|--------|------|---------|
| GET | `/api/v4/leads` | Список сделок |
| GET | `/api/v4/leads/{id}` | Одна сделка |
| POST | `/api/v4/leads` | Создание пакетно |
| POST | `/api/v4/leads/complex` | Создание пакетно вместе с контактом/компанией |
| PATCH | `/api/v4/leads` | Пакетное редактирование |
| PATCH | `/api/v4/leads/{id}` | Редактирование одной |

## Query параметры (GET)

- `with`: `contacts`, `companies`, `catalog_elements`, `loss_reason`, `source`, `is_price_modified_by_robot`, `only_deleted`
- `page`, `limit` (до 250)
- `query` — поиск по значениям полей
- `filter[...]` — `filter[id][]=1`, `filter[statuses][0][pipeline_id]=...&filter[statuses][0][status_id]=...`, `filter[created_at][from]=...`
- `order[created_at|updated_at|id]=asc|desc`

## Ключевые поля

| Поле | Тип | Описание |
|------|-----|----------|
| `name` | string | Название сделки |
| `price` | int | Бюджет |
| `status_id` | int | Статус (этап воронки) |
| `pipeline_id` | int | Воронка |
| `responsible_user_id` | int | Ответственный |
| `created_by` / `updated_by` | int | Автор создания/обновления |
| `closed_at` | int | Unix timestamp закрытия |
| `loss_reason_id` | int | Причина отказа |
| `custom_fields_values` | array | Массив `{field_id, values: [{value, enum_id?}]}` |
| `_embedded.tags` | array | `[{id}]` или `[{name}]` |
| `_embedded.contacts` | array | `[{id, is_main?}]` |
| `_embedded.companies` | array | `[{id}]` |

### tags_to_add / tags_to_delete

При PATCH можно использовать `_embedded.tags_to_add` и `_embedded.tags_to_delete` вместо полной перезаписи.

## Примеры

### Создать сделку

```bash
POST /api/v4/leads
[
  {
    "name": "Сделка с сайта",
    "price": 50000,
    "pipeline_id": 3177727,
    "status_id": 29352079,
    "responsible_user_id": 504141,
    "custom_fields_values": [
      {"field_id": 123456, "values": [{"value": "utm_google"}]}
    ],
    "_embedded": {
      "tags": [{"name": "hot"}],
      "contacts": [{"id": 7, "is_main": true}]
    }
  }
]
```

### Создать сделку с контактом и компанией (complex)

```bash
POST /api/v4/leads/complex
[
  {
    "name": "Сделка + контакт",
    "price": 100000,
    "_embedded": {
      "contacts": [
        {
          "first_name": "Иван",
          "last_name": "Иванов",
          "custom_fields_values": [
            {"field_code": "PHONE", "values": [{"value": "+79990000000", "enum_code": "WORK"}]},
            {"field_code": "EMAIL", "values": [{"value": "i@example.com", "enum_code": "WORK"}]}
          ]
        }
      ]
    }
  }
]
```

Лимит: до 50 сделок за запрос, до 40 custom fields на сущность.

### Обновить сделку (сменить статус)

```bash
PATCH /api/v4/leads/12345
{"status_id": 29352082, "price": 75000}
```

### Массовое обновление

```bash
PATCH /api/v4/leads
[
  {"id": 1, "status_id": 29352082},
  {"id": 2, "responsible_user_id": 504142}
]
```

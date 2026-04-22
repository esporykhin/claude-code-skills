# Contacts API (Контакты)

Base: `https://{subdomain}.amocrm.ru/api/v4/contacts`

## Endpoints

| Method | Path | Purpose |
|--------|------|---------|
| GET | `/api/v4/contacts` | Список контактов |
| GET | `/api/v4/contacts/{id}` | Один контакт |
| POST | `/api/v4/contacts` | Пакетное создание |
| PATCH | `/api/v4/contacts` | Пакетное редактирование |
| PATCH | `/api/v4/contacts/{id}` | Редактирование одного |
| GET | `/api/v4/contacts/chats` | Связи контактов с чатами |
| POST | `/api/v4/contacts/chats` | Привязать чат к контакту |

## Query параметры (GET)

- `with`: `leads`, `customers`, `catalog_elements`, `companies`
- `page`, `limit` (≤250), `query`, `filter[...]`, `order[...]`

## Ключевые поля

| Поле | Описание |
|------|----------|
| `name` | Полное имя (если не задано — из `first_name` + `last_name`) |
| `first_name`, `last_name` | Имя/фамилия |
| `responsible_user_id` | Ответственный |
| `custom_fields_values` | Телефоны/почты/прочее через `field_code` (`PHONE`, `EMAIL`, `POSITION`) и `enum_code` (`WORK`, `MOB`, `HOME`, `OTHER`) |
| `_embedded.tags` | Теги |
| `_embedded.companies` | `[{id}]` (у контакта может быть только одна компания) |

## Примеры

### Поиск по телефону

```
GET /api/v4/contacts?query=%2B79990000000
```

### Создать контакт

```bash
POST /api/v4/contacts
[
  {
    "first_name": "Иван",
    "last_name": "Петров",
    "responsible_user_id": 504141,
    "custom_fields_values": [
      {"field_code": "PHONE", "values": [{"value": "+79990000000", "enum_code": "WORK"}]},
      {"field_code": "EMAIL", "values": [{"value": "i@example.com", "enum_code": "WORK"}]}
    ],
    "_embedded": {
      "tags": [{"name": "import"}],
      "companies": [{"id": 9999}]
    }
  }
]
```

### Обновить контакт (добавить телефон)

При PATCH массив `values` внутри `custom_fields_values` **полностью перезаписывается** — передавай все значения, которые должны остаться.

# Common endpoints

## Account info

```
GET /api/v4/account
GET /api/v4/account?with=users_groups,task_types,entity_names,amojo_id,amojo_rights,users_groups,datetime_settings,version
```

Возвращает: `id`, `name`, `subdomain`, `current_user_id`, `country`, `customers_mode` (`unavailable | disabled | segments | periodicity`), `is_unsorted_on`, `is_loss_reason_enabled`, `is_helpbot_enabled`, `contact_name_display_order`, таймзону и т.п.

## Пользователи

```
GET /api/v4/users
GET /api/v4/users/{id}
```

## Воронки и статусы

```
GET /api/v4/leads/pipelines
GET /api/v4/leads/pipelines/{id}
GET /api/v4/leads/pipelines/{pipeline_id}/statuses
```

Статусы: `142` — Успешно реализовано, `143` — Закрыто и не реализовано. Остальные — кастомные ID воронки.

## Custom fields

```
GET    /api/v4/{entity}/custom_fields
GET    /api/v4/{entity}/custom_fields/{id}
POST   /api/v4/{entity}/custom_fields
PATCH  /api/v4/{entity}/custom_fields
DELETE /api/v4/{entity}/custom_fields/{id}
```

где `{entity}` = `leads`, `contacts`, `companies`, `customers`, `catalogs/{catalog_id}`.

Типы полей: `text`, `numeric`, `checkbox`, `select`, `multiselect`, `date`, `url`, `textarea`, `radiobutton`, `streetaddress`, `smart_address`, `birthday`, `legal_entity`, `date_time`, `price`, `category`, `items`, `tracking_data`, `linked_entity`, `chained_list`, `monetary`, `file`.

Системные `field_code` у контактов/компаний: `PHONE`, `EMAIL`, `IM`, `WEB`, `ADDRESS`, `POSITION`. `enum_code`: `WORK`, `WORKDD`, `MOB`, `FAX`, `HOME`, `OTHER`, `PRIV`.

## Теги

```
GET  /api/v4/{entity}/tags
POST /api/v4/{entity}/tags
```

## События (лента)

```
GET /api/v4/events
GET /api/v4/events/types
```

## Примечания (notes)

```
GET  /api/v4/{entity}/notes
GET  /api/v4/{entity}/{id}/notes
POST /api/v4/{entity}/{id}/notes
PATCH /api/v4/{entity}/{id}/notes
```

Типы: `common`, `call_in`, `call_out`, `service_message`, `message_cashier`, `geolocation`, `sms_in`, `sms_out`, `extended_service_message`, `attachment`.

## Unsorted (неразобранное)

```
GET  /api/v4/leads/unsorted
GET  /api/v4/leads/unsorted/{uid}
POST /api/v4/leads/unsorted/forms
POST /api/v4/leads/unsorted/sip
POST /api/v4/leads/unsorted/{uid}/accept
DELETE /api/v4/leads/unsorted/{uid}
```

## Каталоги (списки)

```
GET  /api/v4/catalogs
GET  /api/v4/catalogs/{id}
POST /api/v4/catalogs
PATCH /api/v4/catalogs
GET  /api/v4/catalogs/{catalog_id}/elements
POST /api/v4/catalogs/{catalog_id}/elements
PATCH /api/v4/catalogs/{catalog_id}/elements
```

## Связи между сущностями

```
GET   /api/v4/{entity}/{id}/links
POST  /api/v4/{entity}/link
POST  /api/v4/{entity}/unlink
```

## HTTP-коды

| Код | Смысл |
|-----|-------|
| 200 | OK (GET/PATCH) |
| 201 | Created (некоторые POST, webhooks) |
| 202 | Accepted (асинхронная операция) |
| 204 | No Content (delete/webhooks delete) |
| 400 | Невалидный запрос / ошибка полей |
| 401 | Нет/протух access_token |
| 402 | Тариф не позволяет |
| 403 | Нет прав |
| 404 | Не найдено |
| 429 | Rate limit — backoff и retry |

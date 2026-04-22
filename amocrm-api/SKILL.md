---
name: amocrm-api
description: amoCRM REST API reference. Use when building integrations with amoCRM, writing code that calls amoCRM API endpoints, debugging amoCRM integrations, or answering questions about amoCRM API capabilities, OAuth 2.0, webhooks, entities (leads, contacts, companies, tasks), rate limits.
---

# amoCRM API

REST API для amoCRM — управление сделками, контактами, компаниями, задачами, воронками, webhooks и т.п. Все запросы идут на поддомен конкретного аккаунта.

## Workflow

1. Проверь наличие `config/.env`. Если его нет — запусти onboarding (см. Authentication).
2. Для любого вызова используй `./scripts/amocrm-request.sh METHOD PATH [--data ...] [--query ...]` — он сам подгрузит токен.
3. Если не знаешь эндпоинт — смотри reference по сущности в `references/`.
4. Для write-операций сначала тест на 1 объекте, затем batch.

## Base URL

```
https://{subdomain}.amocrm.ru/api/v4/{endpoint}
```

Для amoCRM.com аналогично: `https://{subdomain}.amocrm.com/api/v4/`. Это отдельная платформа — токены между `.ru` и `.com` не совместимы.

## Authentication — долгосрочный токен

Используем **долгосрочный токен приватной интеграции**. Не требует рефреша, работает как обычный `Bearer`. Хранится в `config/.env` внутри скилла (файл в `.gitignore`).

Все запросы: `Authorization: Bearer ${AMOCRM_ACCESS_TOKEN}`.

### Onboarding: если `config/.env` не настроен

Агент должен **спросить у пользователя** subdomain + токен и предложить ровно два варианта:

**Вариант 1 — передать токен в чат (агент настроит сам).**
Пользователь присылает `subdomain` и долгосрочный токен. Агент создаёт `config/.env`:

```bash
cp config/.env.example config/.env
# потом перезаписывает значения AMOCRM_SUBDOMAIN и AMOCRM_ACCESS_TOKEN
chmod 600 config/.env
```

**Вариант 2 — настроить самому.**
Пользователь выполняет локально:
```bash
cp config/.env.example config/.env
# отредактировать AMOCRM_SUBDOMAIN и AMOCRM_ACCESS_TOKEN вручную
chmod 600 config/.env
```

### Где взять долгосрочный токен

1. amoCRM → **Настройки → Интеграции → Создать интеграцию → Внутренняя интеграция**
2. Заполнить название и scopes (сделки, контакты, и т.п.)
3. Созданная интеграция → вкладка **"Ключи и доступы"** → **"Сгенерировать долгосрочный токен"**
4. Выбрать срок жизни (до нескольких лет) и скопировать токен — показывается один раз

Также нужны:
- **subdomain** — для `mycompany.amocrm.ru` это `mycompany`
- **домен** — `amocrm.ru` или `amocrm.com` (переменная `AMOCRM_DOMAIN`, по умолчанию `amocrm.ru`)

Подробнее: [config/README.md](config/README.md).

### Приоритет источников

1. Переменные окружения (`AMOCRM_SUBDOMAIN=... ./scripts/amocrm-request.sh ...`) — для one-off вызовов
2. `config/.env` — стандартное хранилище внутри скилла

### Когда нужен OAuth 2.0

Если делаешь публичную интеграцию из каталога amoCRM (для сторонних аккаунтов) — тогда нужен полный OAuth flow (authorization_code → access + refresh, access живёт 24 часа). Для приватной интеграции в свой аккаунт — достаточно долгосрочного токена.

## Request / Response format

- Body: `application/json`
- Успех: `Content-Type: application/hal+json`, HTTP 200/204
- Ошибка: `Content-Type: application/problem+json`, HTTP 400/401/402/403/404

### Общие query параметры (GET-списки)

| Параметр | Описание |
|----------|----------|
| `page` | Страница (от 1) |
| `limit` | До 250 |
| `query` | Поиск по значениям полей |
| `with` | Включить связанные данные (зависит от сущности) |
| `filter[...]` | Фильтрация (`filter[id][]=1`, `filter[created_at][from]=...`) |
| `order[...]` | Сортировка (`order[updated_at]=desc`) |

### HAL-формат

Связанные объекты возвращаются в `_embedded`, пагинация — в `_links.next/prev`.

## Основные сущности

| Раздел | Reference |
|--------|-----------|
| Сделки (Leads) | [references/leads.md](references/leads.md) |
| Контакты (Contacts) | [references/contacts.md](references/contacts.md) |
| Компании (Companies) | [references/companies.md](references/companies.md) |
| Задачи (Tasks) | [references/tasks.md](references/tasks.md) |
| Webhooks | [references/webhooks.md](references/webhooks.md) |
| Общее (аккаунт, кастом-поля, воронки, теги, события, неразобранное) | [references/common.md](references/common.md) |

## Limits и best practices

- `limit` на списках — максимум **250**.
- Пакетное создание/обновление — до **50** объектов (в `leads/complex` также 50).
- До **40** custom fields на сущность в одном запросе.
- Webhooks: **100** подписок на аккаунт.
- Rate limits в публичной доке не фиксированы жёстко; на практике держись ≤ 7 rps на интеграцию, при 429 — экспоненциальный backoff.
- Для массовых операций используй batch-эндпоинты (`POST/PATCH /api/v4/leads` с массивом), а не цикл по одиночным запросам.
- Сразу сохраняй новую пару токенов после refresh — старый refresh умирает моментально.

## Быстрый пример

Через обёртку (рекомендуется):
```bash
./scripts/amocrm-request.sh GET /api/v4/leads --query limit=50 --query with=contacts
./scripts/amocrm-request.sh POST /api/v4/leads \
  --data '[{"name":"Новая сделка","price":10000,"pipeline_id":123,"status_id":456}]'
```

Через curl (если нужен прямой вызов):
```bash
source config/.env
curl -s "https://${AMOCRM_SUBDOMAIN}.${AMOCRM_DOMAIN:-amocrm.ru}/api/v4/leads?limit=50" \
  -H "Authorization: Bearer ${AMOCRM_ACCESS_TOKEN}"
```

## Полезные ссылки

- Обзор: https://www.amocrm.ru/developers/content/crm_platform/api-reference
- OAuth step-by-step: https://www.amocrm.ru/developers/content/oauth/step-by-step
- Фильтрация и сортировка: https://www.amocrm.ru/developers/content/crm_platform/filters-api

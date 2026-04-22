# Kaiten API: Auth & Basics

## Base URL

```
https://{KAITEN_DOMAIN}/api/latest
```

`KAITEN_DOMAIN` — хост вашей инсталляции Kaiten, например `mycompany.kaiten.ru`.
Можно указать с протоколом или без — `_common.sh` нормализует.

## Authentication

Bearer-токен в заголовке:

```
Authorization: Bearer {KAITEN_TOKEN}
```

Как получить токен:

1. Зайти в Kaiten под нужным аккаунтом.
2. Клик по аватару → **Профиль** → вкладка **API**.
3. Нажать **Create new API token**, скопировать значение.

Токен действует от имени пользователя — все действия через API будут совершаться им.

## Credentials storage

Скрипты читают две переменные:

- `KAITEN_DOMAIN`
- `KAITEN_TOKEN`

Источники (в порядке приоритета):

1. Переменные окружения (inline или export).
2. `config/.env` внутри скилла (рекомендуется для постоянного использования):
   ```
   KAITEN_DOMAIN=mycompany.kaiten.ru
   KAITEN_TOKEN=eyJhbGciOi...
   ```
   `_common.sh` подгружает этот файл автоматически. Файл в `.gitignore`, не коммитится.

Как настроить: см. `config/README.md`.

Если переменные не установлены — скрипт выйдет с понятной ошибкой и ссылкой на `config/README.md`.

## Typical Error Codes

- `200/201` — OK
- `400` — bad payload / validation
- `401` — missing/invalid token
- `403` — no permission for the resource
- `404` — not found
- `409` — state conflict (например, попытка изменить удалённую карточку)
- `429` — rate limit exceeded
- `5xx` — server error

## Practical Notes

- Все запросы — JSON (`Content-Type: application/json`).
- Для GET-фильтров используется query string (`?board_id=123&limit=50`).
- `limit` обычно ограничен 100 — большие выборки листаются через `offset`.
- ID объектов — целые числа.
- Пустой PATCH без тела — нежелателен, всегда шли минимум `{}`.
- API-токен нельзя коммитить в репозиторий.

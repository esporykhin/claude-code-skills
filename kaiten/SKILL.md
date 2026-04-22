---
name: kaiten
version: 1.0.0
description: "Kaiten API operations — карточки, доски, пространства, колонки, комментарии, пользователи, теги. Use when пользователь просит создать/найти/обновить/переместить карточку в Kaiten, добавить комментарий, получить структуру пространств/досок, или сделать произвольный запрос к Kaiten API (developers.kaiten.ru)."
license: MIT
metadata:
  author: evgeny
  version: "1.0.0"
---

# Kaiten API

Скилл для работы с [Kaiten API](https://developers.kaiten.ru) через готовые bash-скрипты.

Покрывает:

- карточки (CRUD, перемещение, назначение исполнителей, теги, чеклисты)
- комментарии
- доски, колонки, дорожки (lanes)
- пространства (spaces)
- пользователи, теги, типы карточек
- произвольные запросы к любому endpoint Kaiten

## When to Apply

- «Создай карточку в Kaiten…»
- «Перенеси карточку в колонку Done / на доску X»
- «Покажи мои карточки / найди карточку по названию»
- «Добавь комментарий к карточке N»
- «Покажи доски пространства X / колонки доски Y»
- Любой запрос «в Kaiten …»

## Base URL & Auth

```text
Base URL: https://{KAITEN_DOMAIN}/api/latest
Auth:     Authorization: Bearer {KAITEN_TOKEN}
```

- `KAITEN_DOMAIN` — хост инсталляции, например `mycompany.kaiten.ru`.
- `KAITEN_TOKEN` — персональный API-токен. Как получить: **Kaiten → аватар → Профиль → API → Create new API token**.

## Credentials

Скрипты читают две переменные окружения:

- `KAITEN_DOMAIN`
- `KAITEN_TOKEN`

Варианты, где их держать (рекомендуется первый):

1. `~/.claude/credentials.env` (права 600), Claude Code автоматически их подхватит:
   ```bash
   KAITEN_DOMAIN=mycompany.kaiten.ru
   KAITEN_TOKEN=eyJhbGciOi...
   ```
2. Export в текущей сессии: `export KAITEN_DOMAIN=... KAITEN_TOKEN=...`

Если переменных нет — **сначала спроси пользователя** домен и токен, сохрани в `~/.claude/credentials.env` и только потом продолжай.

## Documentation References

- `references/auth.md` — авторизация, переменные окружения, типовые ошибки
- `references/api.md` — основные endpoint'ы (cards, boards, spaces, columns, comments, users, tags)

## Scripts

Все скрипты лежат в `scripts/`. Общая точка входа для произвольных запросов — `kaiten-request.sh`.

| Script | Purpose | Usage |
|--------|---------|-------|
| `kaiten-request.sh` | Произвольный запрос к любому endpoint | `./scripts/kaiten-request.sh GET /cards --query '{"limit":10}'` |
| `methods/spaces-list.sh` | Список пространств | `./scripts/methods/spaces-list.sh` |
| `methods/boards-list.sh` | Список досок (опц. по space_id) | `./scripts/methods/boards-list.sh [space_id]` |
| `methods/columns-list.sh` | Колонки доски | `./scripts/methods/columns-list.sh <board_id>` |
| `methods/lanes-list.sh` | Дорожки доски | `./scripts/methods/lanes-list.sh <board_id>` |
| `methods/cards-list.sh` | Список карточек (JSON query) | `./scripts/methods/cards-list.sh '{"board_id":123,"limit":50}'` |
| `methods/card-get.sh` | Карточка по id | `./scripts/methods/card-get.sh <card_id>` |
| `methods/card-create.sh` | Создать карточку | `./scripts/methods/card-create.sh payload.json` |
| `methods/card-update.sh` | Обновить карточку (PATCH) | `./scripts/methods/card-update.sh <card_id> payload.json` |
| `methods/card-move.sh` | Переместить в колонку/lane | `./scripts/methods/card-move.sh <card_id> <column_id> [lane_id]` |
| `methods/card-archive.sh` | Архивировать карточку | `./scripts/methods/card-archive.sh <card_id>` |
| `methods/card-delete.sh` | Удалить карточку | `./scripts/methods/card-delete.sh <card_id>` |
| `methods/card-comment.sh` | Добавить комментарий | `./scripts/methods/card-comment.sh <card_id> "текст"` |
| `methods/card-comments-list.sh` | Список комментариев | `./scripts/methods/card-comments-list.sh <card_id>` |
| `methods/card-members-add.sh` | Добавить участника | `./scripts/methods/card-members-add.sh <card_id> <user_id>` |
| `methods/card-tag-add.sh` | Добавить тег | `./scripts/methods/card-tag-add.sh <card_id> <tag_name>` |
| `methods/users-list.sh` | Список пользователей | `./scripts/methods/users-list.sh` |
| `methods/current-user.sh` | Текущий пользователь (whoami) | `./scripts/methods/current-user.sh` |
| `methods/tags-list.sh` | Список тегов | `./scripts/methods/tags-list.sh` |

## Which Script to Use

- «Создай карточку …» → `card-create.sh` (payload обязательно содержит `title` + `board_id` или `column_id`).
- «Перемести карточку …» → `card-move.sh`. Нужны column_id (и lane_id) — получи через `columns-list.sh`/`lanes-list.sh`.
- «Обнови карточку …» → `card-update.sh` с payload `{"title":...,"description":...,"due_date":...}`.
- «Добавь комментарий …» → `card-comment.sh`.
- «Покажи доски / колонки …» → `boards-list.sh` → `columns-list.sh`.
- «Найди мои карточки / по доске / по автору» → `cards-list.sh` с фильтрами (`board_id`, `space_id`, `owner_id`, `member_ids`, `query`, `condition`, `archived`).
- Любой другой endpoint → `kaiten-request.sh`.

## Conventions

- Base URL всегда `https://{KAITEN_DOMAIN}/api/latest`.
- Content-Type: `application/json`.
- Ответы — JSON, пайпи через `jq` для чтения.
- Пагинация: `limit` (макс. обычно 100) + `offset`.
- Идентификаторы — целые числа.

## Error Codes

- `200/201` — успех
- `400` — невалидный payload
- `401` — нет/невалидный токен
- `403` — нет прав
- `404` — объект не найден
- `429` — rate limit
- `5xx` — ошибка сервера

# Kaiten API: Endpoint Reference

Base URL: `https://{KAITEN_DOMAIN}/api/latest`
Auth: `Authorization: Bearer {KAITEN_TOKEN}`

Полная документация: https://developers.kaiten.ru

## Spaces

| Method | Endpoint | Purpose |
|--------|----------|---------|
| GET | `/spaces` | Список пространств |
| GET | `/spaces/{id}` | Одно пространство |
| POST | `/spaces` | Создать пространство `{title}` |
| PATCH | `/spaces/{id}` | Обновить |
| DELETE | `/spaces/{id}` | Удалить |

## Boards

| Method | Endpoint | Purpose |
|--------|----------|---------|
| GET | `/boards` | Все доски |
| GET | `/spaces/{space_id}/boards` | Доски пространства |
| GET | `/boards/{id}` | Одна доска |
| POST | `/boards` | Создать доску `{title, space_id}` |
| PATCH | `/boards/{id}` | Обновить |
| DELETE | `/boards/{id}` | Удалить |

## Columns & Lanes

| Method | Endpoint | Purpose |
|--------|----------|---------|
| GET | `/boards/{board_id}/columns` | Колонки |
| POST | `/boards/{board_id}/columns` | Создать колонку `{title}` |
| PATCH | `/columns/{id}` | Обновить |
| DELETE | `/columns/{id}` | Удалить |
| GET | `/boards/{board_id}/lanes` | Дорожки |
| POST | `/boards/{board_id}/lanes` | Создать `{title}` |

## Cards

| Method | Endpoint | Purpose |
|--------|----------|---------|
| GET | `/cards` | Список с фильтрами (query string) |
| GET | `/cards/{id}` | Карточка с деталями |
| POST | `/cards` | Создать |
| PATCH | `/cards/{id}` | Обновить (в т.ч. переместить) |
| DELETE | `/cards/{id}` | Удалить |

### Cards list — фильтры

Можно комбинировать:

- `board_id`, `space_id`, `column_id`, `lane_id`
- `owner_id`, `member_ids` (CSV)
- `query` — поиск по названию
- `archived` — `0` / `1`
- `condition` — `1`/`2`/`3` (live/done/archived, зависит от инсталляции)
- `limit` (≤100), `offset`
- `created_after`, `created_before` — ISO datetime
- `updated_after`, `updated_before`

### Card create — минимальный payload

```json
{"title": "Fix login", "board_id": 123, "column_id": 456}
```

Полезные поля: `lane_id`, `description` (markdown), `owner_id`, `members` (массив id),
`tags` (массив имён), `type_id`, `due_date` (ISO), `properties` (кастомные поля),
`checklists` (`[{name, items:[{text}]}]`).

### Card move

Перемещение = `PATCH /cards/{id}` с `{"column_id":...,"lane_id":...}`.

## Comments

| Method | Endpoint | Purpose |
|--------|----------|---------|
| GET | `/cards/{card_id}/comments` | Список комментариев |
| POST | `/cards/{card_id}/comments` | Добавить `{text}` |
| PATCH | `/cards/{card_id}/comments/{id}` | Редактировать |
| DELETE | `/cards/{card_id}/comments/{id}` | Удалить |

## Members on card

| Method | Endpoint | Purpose |
|--------|----------|---------|
| POST | `/cards/{card_id}/members` | Добавить `{user_id}` |
| DELETE | `/cards/{card_id}/members/{user_id}` | Убрать |

## Tags

| Method | Endpoint | Purpose |
|--------|----------|---------|
| GET | `/tags` | Все теги |
| POST | `/cards/{card_id}/tags` | Повесить `{name}` |
| DELETE | `/cards/{card_id}/tags/{tag_id}` | Снять |

## Checklists

| Method | Endpoint | Purpose |
|--------|----------|---------|
| POST | `/cards/{card_id}/checklists` | Создать `{name}` |
| POST | `/cards/{card_id}/checklists/{id}/items` | Пункт `{text}` |
| PATCH | `/cards/{card_id}/checklists/{id}/items/{item_id}` | Отметить `{checked:true}` |

## Custom properties

| Method | Endpoint | Purpose |
|--------|----------|---------|
| GET | `/company/custom-properties` | Справочник полей |
| PATCH | `/cards/{id}` | Передать `{properties: {id_X: value}}` |

## Users

| Method | Endpoint | Purpose |
|--------|----------|---------|
| GET | `/users` | Все пользователи компании |
| GET | `/users/current` | Текущий (whoami) |
| GET | `/users/{id}` | По id |

## Arbitrary requests

Любой endpoint — через `scripts/kaiten-request.sh`:

```bash
./scripts/kaiten-request.sh GET  /cards --query '{"board_id":123,"limit":10}'
./scripts/kaiten-request.sh POST /cards --file payload.json
./scripts/kaiten-request.sh PATCH /cards/456 --data '{"title":"New"}'
./scripts/kaiten-request.sh DELETE /cards/456
```

# Tasks API (Задачи)

Base: `https://{subdomain}.amocrm.ru/api/v4/tasks`

## Endpoints

| Method | Path | Purpose |
|--------|------|---------|
| GET | `/api/v4/tasks` | Список задач |
| GET | `/api/v4/tasks/{id}` | Одна задача |
| POST | `/api/v4/tasks` | Пакетное создание |
| PATCH | `/api/v4/tasks` | Пакетное обновление |
| PATCH | `/api/v4/tasks/{id}` | Одной |

## Query (GET)

- `filter[responsible_user_id][]`, `filter[is_completed]=0|1`, `filter[task_type][]`, `filter[entity_type]=leads|contacts|companies|customers`, `filter[entity_id][]`, `filter[updated_at][from|to]`
- `order[created_at|complete_till|id]=asc|desc`

## Ключевые поля

| Поле | Тип | Описание |
|------|-----|----------|
| `task_type_id` | int | 1 = Звонок, 2 = Встреча, дальше кастомные |
| `entity_type` | string | `leads`, `contacts`, `companies`, `customers` |
| `entity_id` | int | К какому объекту привязана |
| `text` | string | **required** — описание |
| `complete_till` | int | **required** — unix timestamp дедлайна |
| `is_completed` | bool | Закрыта ли |
| `responsible_user_id` | int | Ответственный |
| `result.text` | string | Комментарий при завершении |

## Примеры

### Создать задачу-звонок на сделку

```bash
POST /api/v4/tasks
[
  {
    "task_type_id": 1,
    "text": "Позвонить и квалифицировать",
    "complete_till": 1714000000,
    "entity_type": "leads",
    "entity_id": 12345,
    "responsible_user_id": 504141
  }
]
```

### Закрыть задачу

```bash
PATCH /api/v4/tasks/999
{
  "is_completed": true,
  "result": {"text": "Созвонились, назначили встречу"}
}
```

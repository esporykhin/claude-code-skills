# Webhooks API

Base: `https://{subdomain}.amocrm.ru/api/v4/webhooks`

## Endpoints

| Method | Path | Purpose |
|--------|------|---------|
| GET | `/api/v4/webhooks` | Список подписок |
| POST | `/api/v4/webhooks` | Подписаться |
| DELETE | `/api/v4/webhooks` | Отписаться |

- Админ-права аккаунта — обязательно.
- До **100** подписок на аккаунт.
- Успех: 201 (create) / 204 (delete).

## Подписка

```bash
POST /api/v4/webhooks
{
  "destination": "https://example.com/amocrm/hook",
  "settings": ["add_lead", "status_lead", "update_contact"]
}
```

## Основные события

**Сделки:** `add_lead`, `update_lead`, `delete_lead`, `status_lead`, `responsible_lead`, `restore_lead`
**Контакты:** `add_contact`, `update_contact`, `delete_contact`, `responsible_contact`, `restore_contact`
**Компании:** `add_company`, `update_company`, `delete_company`, `responsible_company`, `restore_company`
**Задачи:** `add_task`, `update_task`, `delete_task`, `responsible_task`
**Покупатели:** `add_customer`, `update_customer`, `delete_customer`, `responsible_customer`
**Примечания:** `note_lead`, `note_contact`, `note_company`, `note_customer`
**Прочее:** `add_talk`, `update_talk`, шаблоны чатов

## Формат входящих payload

amoCRM шлёт `application/x-www-form-urlencoded` (не JSON). Пример payload для `add_lead`:

```
leads[add][0][id]=12345
leads[add][0][name]=Сделка
leads[add][0][status_id]=29352079
leads[add][0][price]=10000
leads[add][0][responsible_user_id]=504141
leads[add][0][last_modified]=1714000000
account[subdomain]=mycompany
account[id]=1234567
```

На стороне получателя — парси как form-data, отвечай **HTTP 200** быстро (≤2 сек), иначе amoCRM будет ретраить и в итоге отключит вебхук.

## Отписка

```bash
DELETE /api/v4/webhooks
{"destination": "https://example.com/amocrm/hook"}
```

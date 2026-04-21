# Notification

- Category key: `notification`
- Methods in local catalog: `7`

## How To Use

1. Найди нужный метод по таблице ниже.
2. Если payload неочевиден, сверяйся с source doc или официальной документацией Ozon.
3. Запускай wrapper из колонки `script`.
4. Если wrapper есть, но нужно проверить wording или соседние методы, открой source markdown только для этого куска.

## Methods

| method | http | path | script | note |
|---|---|---|---|---|
| `postNotificationCheck` | `POST` | `/v1/notification/check` | `scripts/methods/notification/post-notification-check.sh` | Проверить URL-адрес для уведомлений |
| `deleteNotificationDelete` | `DELETE` | `/v1/notification/delete` | `scripts/methods/notification/delete-notification-delete.sh` | Удалить URL-адрес для уведомлений |
| `postNotificationEnable` | `POST` | `/v1/notification/enable` | `scripts/methods/notification/post-notification-enable.sh` | Включить или выключить уведомления на URL-адрес |
| `postNotificationList` | `POST` | `/v1/notification/list` | `scripts/methods/notification/post-notification-list.sh` | Получить информацию по подключённым URL-адресам |
| `postNotificationPushTypeList` | `POST` | `/v1/notification/push-type/list` | `scripts/methods/notification/post-notification-push-type-list.sh` | Получить типы пуш-уведомлений |
| `postNotificationSet` | `POST` | `/v1/notification/set` | `scripts/methods/notification/post-notification-set.sh` | Подключить URL-адрес для уведомлений |
| `postNotificationUpdate` | `POST` | `/v1/notification/update` | `scripts/methods/notification/post-notification-update.sh` | Изменить URL-адрес для уведомлений |

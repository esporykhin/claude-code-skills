# Ozon Logistics

- Category key: `ozon-logistics`
- Methods in local catalog: `8`

## How To Use

1. Найди нужный метод по таблице ниже.
2. Если payload неочевиден, сверяйся с source doc или официальной документацией Ozon.
3. Запускай wrapper из колонки `script`.
4. Если wrapper есть, но нужно проверить wording или соседние методы, открой source markdown только для этого куска.

## Methods

| method | http | path | script | note |
|---|---|---|---|---|
| `postDeliveryCheck` | `POST` | `/v1/delivery/check` | `scripts/methods/ozon-logistics/post-delivery-check.sh` | Проверить доступность доставки для покупателя |
| `postDeliveryMap` | `POST` | `/v1/delivery/map` | `scripts/methods/ozon-logistics/post-delivery-map.sh` | Отрисовать точки на карте |
| `postDeliveryPointInfo` | `POST` | `/v1/delivery/point/info` | `scripts/methods/ozon-logistics/post-delivery-point-info.sh` | Получить информацию о точке самовывоза |
| `postDeliveryPointList` | `POST` | `/v1/delivery/point/list` | `scripts/methods/ozon-logistics/post-delivery-point-list.sh` | Получить список точек самовывоза |
| `postPostingCancel` | `POST` | `/v1/posting/cancel` | `scripts/methods/ozon-logistics/post-posting-cancel.sh` | Отменить отправление из заказа |
| `postPostingCancelStatus` | `POST` | `/v1/posting/cancel/status` | `scripts/methods/ozon-logistics/post-posting-cancel-status.sh` | Проверить статус отмены отправления |
| `postDeliveryCheckout` | `POST` | `/v2/delivery/checkout` | `scripts/methods/ozon-logistics/post-delivery-checkout.sh` | Получить доступные варианты доставки |
| `postOrderCreate` | `POST` | `/v2/order/create` | `scripts/methods/ozon-logistics/post-order-create.sh` | Создать заказ |

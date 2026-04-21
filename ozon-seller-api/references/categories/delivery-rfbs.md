# Delivery Rfbs

- Category key: `delivery-rfbs`
- Methods in local catalog: `5`

## How To Use

1. Найди нужный метод по таблице ниже.
2. Если payload неочевиден, сверяйся с source doc или официальной документацией Ozon.
3. Запускай wrapper из колонки `script`.
4. Если wrapper есть, но нужно проверить wording или соседние методы, открой source markdown только для этого куска.

## Methods

| method | http | path | script | note |
|---|---|---|---|---|
| `setCutoff` | `POST` | `/v1/posting/cutoff/set` | `scripts/methods/delivery-rfbs/set-cutoff.sh` | Уточнить дату отгрузки отправления |
| `setDelivered` | `POST` | `/v2/fbs/posting/delivered` | `scripts/methods/delivery-rfbs/set-delivered.sh` | Изменить статус на «Доставлено» |
| `setDelivering` | `POST` | `/v2/fbs/posting/delivering` | `scripts/methods/delivery-rfbs/set-delivering.sh` | Изменить статус на «Доставляется» |
| `setLastMile` | `POST` | `/v2/fbs/posting/last-mile` | `scripts/methods/delivery-rfbs/set-last-mile.sh` | Изменить статус на «Последняя миля» |
| `setTrackingNumbers` | `POST` | `/v2/fbs/posting/tracking-number/set` | `scripts/methods/delivery-rfbs/set-tracking-numbers.sh` | Добавить трек-номера |

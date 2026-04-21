# Pricing Strategy

- Category key: `pricing-strategy`
- Methods in local catalog: `12`

## How To Use

1. Найди нужный метод по таблице ниже.
2. Если payload неочевиден, сверяйся с source doc или официальной документацией Ozon.
3. Запускай wrapper из колонки `script`.
4. Если wrapper есть, но нужно проверить wording или соседние методы, открой source markdown только для этого куска.

## Methods

| method | http | path | script | note |
|---|---|---|---|---|
| `getCompetitors` | `POST` | `/v1/pricing-strategy/competitors/list` | `scripts/methods/pricing-strategy/get-competitors.sh` | Список конкурентов |
| `createStrategy` | `POST` | `/v1/pricing-strategy/create` | `scripts/methods/pricing-strategy/create-strategy.sh` | Создать стратегию |
| `deleteStrategy` | `DELETE` | `/v1/pricing-strategy/delete` | `scripts/methods/pricing-strategy/delete-strategy.sh` | Удалить стратегию |
| `getStrategyInfo` | `POST` | `/v1/pricing-strategy/info` | `scripts/methods/pricing-strategy/get-strategy-info.sh` | Информация о стратегии |
| `getStrategiesList` | `POST` | `/v1/pricing-strategy/list` | `scripts/methods/pricing-strategy/get-strategies-list.sh` | Список стратегий |
| `getStrategyItemInfo` | `POST` | `/v1/pricing-strategy/product/info` | `scripts/methods/pricing-strategy/get-strategy-item-info.sh` | Цена товара у конкурента |
| `addItemsToStrategy` | `POST` | `/v1/pricing-strategy/products/add` | `scripts/methods/pricing-strategy/add-items-to-strategy.sh` | Добавить товары в стратегию |
| `removeItemsFromStrategy` | `DELETE` | `/v1/pricing-strategy/products/delete` | `scripts/methods/pricing-strategy/remove-items-from-strategy.sh` | Удалить товары из стратегии |
| `getStrategyItems` | `POST` | `/v1/pricing-strategy/products/list` | `scripts/methods/pricing-strategy/get-strategy-items.sh` | Список товаров в стратегии |
| `updateStrategyStatus` | `POST` | `/v1/pricing-strategy/status` | `scripts/methods/pricing-strategy/update-strategy-status.sh` | Изменить статус стратегии |
| `getStrategyIDsByItemIDs` | `POST` | `/v1/pricing-strategy/strategy-ids-by-product-ids` | `scripts/methods/pricing-strategy/get-strategy-i-ds-by-item-i-ds.sh` | Список идентификаторов стратегий |
| `updateStrategy` | `POST` | `/v1/pricing-strategy/update` | `scripts/methods/pricing-strategy/update-strategy.sh` | Обновить стратегию |

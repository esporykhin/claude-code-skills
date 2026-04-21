# Promos

- Category key: `promos`
- Methods in local catalog: `9`

## How To Use

1. Найди нужный метод по таблице ниже.
2. Если payload неочевиден, сверяйся с source doc или официальной документацией Ozon.
3. Запускай wrapper из колонки `script`.
4. Если wrapper есть, но нужно проверить wording или соседние методы, открой source markdown только для этого куска.

## Methods

| method | http | path | script | note |
|---|---|---|---|---|
| `getActions` | `GET` | `/v1/actions` | `scripts/methods/promos/get-actions.sh` | Список акций |
| `getCandidates` | `POST` | `/v1/actions/candidates` | `scripts/methods/promos/get-candidates.sh` | Список доступных для акции товаров |
| `approveDiscountTasks` | `POST` | `/v1/actions/discounts-task/approve` | `scripts/methods/promos/approve-discount-tasks.sh` | Согласовать заявку на скидку |
| `declineDiscountTasks` | `POST` | `/v1/actions/discounts-task/decline` | `scripts/methods/promos/decline-discount-tasks.sh` | Отклонить заявку на скидку |
| `getDiscountTasks` | `POST` | `/v1/actions/discounts-task/list` | `scripts/methods/promos/get-discount-tasks.sh` | Список заявок на скидку |
| `getParticipatingProducts` | `POST` | `/v1/actions/products` | `scripts/methods/promos/get-participating-products.sh` | Список участвующих в акции товаров |
| `activateProducts` | `POST` | `/v1/actions/products/activate` | `scripts/methods/promos/activate-products.sh` | Добавить товар в акцию |
| `deactivateProducts` | `POST` | `/v1/actions/products/deactivate` | `scripts/methods/promos/deactivate-products.sh` | Удалить товары из акции |
| `postActionsDiscountsTaskList` | `POST` | `/v2/actions/discounts-task/list` | `scripts/methods/promos/post-actions-discounts-task-list.sh` | Получить список заявок на скидку |

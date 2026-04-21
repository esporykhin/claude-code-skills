# Rfbs Returns

- Category key: `rfbs-returns`
- Methods in local catalog: `8`

## How To Use

1. Найди нужный метод по таблице ниже.
2. Если payload неочевиден, сверяйся с source doc или официальной документацией Ozon.
3. Запускай wrapper из колонки `script`.
4. Если wrapper есть, но нужно проверить wording или соседние методы, открой source markdown только для этого куска.

## Methods

| method | http | path | script | note |
|---|---|---|---|---|
| `setAction` | `POST` | `/v1/returns/rfbs/action/set` | `scripts/methods/rfbs-returns/set-action.sh` | Передать доступные действия для rFBS возвратов |
| `compensate` | `POST` | `/v2/returns/rfbs/compensate` | `scripts/methods/rfbs-returns/compensate.sh` | Вернуть часть стоимости товара |
| `getReturn` | `GET` | `/v2/returns/rfbs/get` | `scripts/methods/rfbs-returns/get-return.sh` | Информация о заявке на возврат |
| `getReturnsList` | `POST` | `/v2/returns/rfbs/list` | `scripts/methods/rfbs-returns/get-returns-list.sh` | Список заявок на возврат |
| `receiveReturn` | `POST` | `/v2/returns/rfbs/receive-return` | `scripts/methods/rfbs-returns/receive-return.sh` | Подтвердить получение товара на проверку |
| `reject` | `POST` | `/v2/returns/rfbs/reject` | `scripts/methods/rfbs-returns/reject.sh` | Отклонить заявку на возврат |
| `returnMoney` | `POST` | `/v2/returns/rfbs/return-money` | `scripts/methods/rfbs-returns/return-money.sh` | Вернуть деньги покупателю |
| `verify` | `POST` | `/v2/returns/rfbs/verify` | `scripts/methods/rfbs-returns/verify.sh` | Одобрить заявку на возврат |

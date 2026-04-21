# Cancellation

- Category key: `cancellation`
- Methods in local catalog: `9`

## How To Use

1. Найди нужный метод по таблице ниже.
2. Если payload неочевиден, сверяйся с source doc или официальной документацией Ozon.
3. Запускай wrapper из колонки `script`.
4. Если wrapper есть, но нужно проверить wording или соседние методы, открой source markdown только для этого куска.

## Methods

| method | http | path | script | note |
|---|---|---|---|---|
| `postCancelReasonList` | `POST` | `/v1/cancel-reason/list` | `scripts/methods/cancellation/post-cancel-reason-list.sh` | Причины отмены отправлений |
| `postCancelReasonListByOrder` | `POST` | `/v1/cancel-reason/list-by-order` | `scripts/methods/cancellation/post-cancel-reason-list-by-order.sh` | Причины отмены заказа |
| `postCancelReasonListByPosting` | `POST` | `/v1/cancel-reason/list-by-posting` | `scripts/methods/cancellation/post-cancel-reason-list-by-posting.sh` | Причины отмены отправления |
| `postOrderCancel` | `POST` | `/v1/order/cancel` | `scripts/methods/cancellation/post-order-cancel.sh` | Отменить заказ |
| `postOrderCancelCheck` | `POST` | `/v1/order/cancel/check` | `scripts/methods/cancellation/post-order-cancel-check.sh` | Отменить заказ |
| `postOrderCancelStatus` | `POST` | `/v1/order/cancel/status` | `scripts/methods/cancellation/post-order-cancel-status.sh` | Получить статус отмены заказа |
| `approveConditionalCancellationV2` | `POST` | `/v2/conditional-cancellation/approve` | `scripts/methods/cancellation/approve-conditional-cancellation-v2.sh` | Подтвердить заявку на отмену rFBS |
| `getConditionalCancellationListV2` | `POST` | `/v2/conditional-cancellation/list` | `scripts/methods/cancellation/get-conditional-cancellation-list-v2.sh` | Получить список заявок на отмену rFBS |
| `rejectConditionalCancellationV2` | `POST` | `/v2/conditional-cancellation/reject` | `scripts/methods/cancellation/reject-conditional-cancellation-v2.sh` | Отклонить заявку на отмену rFBS |

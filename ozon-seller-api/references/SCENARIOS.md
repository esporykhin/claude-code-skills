# Ozon Seller API Scenarios

Открывай этот файл, если задача описана бизнес-языком, а не именем endpoint.

## Fast Routing

- Нужно получить товары, цены, остатки, картинки, атрибуты, видимость:
  `references/categories/product.md`
- Нужно обновить цены, остатки, таймер минимальной цены, скидки:
  `references/categories/product.md`
- Нужно понять категории, атрибуты и справочники значений:
  `references/categories/category.md`
- Нужно работать с FBS-заказами:
  `references/categories/fbs.md`
- Нужно собрать/отгрузить FBS, получить акт, этикетки, штрихкоды:
  `references/categories/fbs.md`
- Нужно работать с маркировкой и экземплярами товаров:
  `references/categories/fbs-rfbs-marks.md`
- Нужно работать с FBO-отправлениями:
  `references/categories/fbo.md`
- Нужно работать со складами FBS/rFBS, методами доставки, первой милей:
  `references/categories/warehouse.md`
- Нужно создавать поставки, черновики, грузоместа, таймслоты:
  `references/categories/fbo-supply-request.md`
- Нужно работать с FBP:
  `references/categories/fbp.md`
- Нужно работать с возвратами FBO/FBS:
  `references/categories/returns.md` и `references/categories/return.md`
- Нужно работать с возвратами rFBS:
  `references/categories/rfbs-returns.md`
- Нужно работать с отменами:
  `references/categories/cancellation.md`
- Нужно работать с чатами:
  `references/categories/chat.md`
- Нужно работать с отзывами:
  `references/categories/review.md`
- Нужно работать с вопросами и ответами:
  `references/categories/questions-answers.md`
- Нужно получить отчёт, сгенерировать файл, узнать статус отчёта:
  `references/categories/report.md`
- Нужно получить аналитику по остаткам, оборачиваемости, доставке:
  `references/categories/analytics.md`
- Нужно получить финансовые транзакции, реализацию, взаиморасчёты:
  `references/categories/finance.md`
- Нужно получить рейтинги продавца:
  `references/categories/seller-rating.md`
- Нужно работать с Ozon Логистикой, отменой заказа, checkout, delivery points:
  `references/categories/ozon-logistics.md`
- Нужно работать с акциями Ozon:
  `references/categories/promos.md`
- Нужно работать с акциями продавца:
  `references/categories/seller-actions.md`
- Нужно работать со стратегиями ценообразования:
  `references/categories/pricing-strategy.md`
- Нужно работать с уведомлениями:
  `references/categories/notification.md`

## Method Selection Rules

- Если задача звучит как "получить список" или "узнать статус", сначала выбирай read-метод.
- Если задача звучит как "создать", "обновить", "подтвердить", "отменить", "привязать", это почти всегда write-метод.
- Если задача звучит как "не знаю точный endpoint", сначала используй `scripts/ozon-find-method.sh`.
- Если категория понятна, но payload неясен, читай только нужный `references/categories/<category>.md`.
- Если endpoint спорный или версия метода смущает, используй `scripts/ozon-request.sh` и минимальный payload.

## Practical Defaults

- Товары:
  сначала `post-product-list`, потом `get-product-info-list-v3`, потом write-методы.
- FBS:
  сначала `get-posting-list-v3` или `get-unfulfilled-list-v3`, потом операции сборки/этикеток/акта.
- Возвраты:
  сначала list/info, потом approve/reject/receive/return-money.
- Финансы и отчёты:
  сначала list/create, потом info/status или скачивание результата.

# Ozon Seller API Index

Открывай этот файл первым, чтобы понять, какой раздел доки нужен дальше.

Если задача сформулирована как бизнес-сценарий, а не как endpoint, сначала открой `SCENARIOS.md`.

## Order of Reading

1. `auth-and-safety.md`
2. Этот индекс
3. `SCENARIOS.md`, если нужно понять "что чем делать"
4. Нужный файл из `categories/`
5. Конкретный wrapper из `scripts/methods/`

## Business Domains

### Catalog and Content

- `seller` -> базовая информация по кабинету и ролям API-ключа -> `references/categories/seller.md`
- `category` -> дерево категорий, атрибуты, справочники значений -> `references/categories/category.md`
- `product` -> товары, цены, остатки, картинки, видимость, SKU, архив -> `references/categories/product.md`
- `barcode` -> генерация и привязка штрихкодов -> `references/categories/barcode.md`
- `brand` -> сертифицируемые бренды -> `references/categories/brand.md`
- `certification` -> сертификаты качества и их статусы -> `references/categories/certification.md`
- `digital` -> цифровые товары и цифровые коды -> `references/categories/digital.md`
- `quants` -> кванты и отгрузка по квантам -> `references/categories/quants.md`

### Pricing and Promotions

- `pricing-strategy` -> стратегии ценообразования и конкуренты -> `references/categories/pricing-strategy.md`
- `promos` -> акции Ozon -> `references/categories/promos.md`
- `seller-actions` -> акции продавца -> `references/categories/seller-actions.md`
- `premium` -> premium-методы: product queries, analytics data, prices details -> `references/categories/premium.md`
- `search-queries` -> поисковые запросы -> `references/categories/search-queries.md`

### Warehouses and Supply

- `warehouse` -> склады FBS/rFBS, delivery methods, первая миля, архив -> `references/categories/warehouse.md`
- `fbo-supply-request` -> поставки FBO, черновики, грузоместа, таймслоты -> `references/categories/fbo-supply-request.md`
- `carriage` -> перевозки, акты расхождений, assembly lists -> `references/categories/carriage.md`
- `pass` -> пропуска -> `references/categories/pass.md`
- `fbp` -> поставки по схеме FBP -> `references/categories/fbp.md`
- `invoice` -> счёт-фактуры -> `references/categories/invoice.md`

### Orders and Logistics

- `fbo` -> FBO-отправления -> `references/categories/fbo.md`
- `fbs` -> FBS-отправления, акты, этикетки, сборка, отгрузка -> `references/categories/fbs.md`
- `fbs-rfbs-marks` -> маркировка и экземпляры товаров -> `references/categories/fbs-rfbs-marks.md`
- `delivery-rfbs` -> статусы rFBS-доставки и tracking -> `references/categories/delivery-rfbs.md`
- `ozon-logistics` -> checkout, delivery points, order cancel, posting cancel -> `references/categories/ozon-logistics.md`
- `polygon` -> полигоны доставки -> `references/categories/polygon.md`

### Returns and Support

- `returns` -> возвраты FBO/FBS и настройки автоутилизации -> `references/categories/returns.md`
- `return` -> возвратные отгрузки и выдача по штрихкоду -> `references/categories/return.md`
- `rfbs-returns` -> заявки на возврат rFBS -> `references/categories/rfbs-returns.md`
- `cancellation` -> заявки на отмену и причины отмен -> `references/categories/cancellation.md`
- `chat` -> чаты и сообщения -> `references/categories/chat.md`
- `review` -> отзывы -> `references/categories/review.md`
- `questions-answers` -> вопросы и ответы -> `references/categories/questions-answers.md`
- `notification` -> пуш-уведомления -> `references/categories/notification.md`

### Finance and Analytics

- `analytics` -> остатки, оборачиваемость, среднее время доставки -> `references/categories/analytics.md`
- `finance` -> реализация, транзакции, взаиморасчёты, компенсации -> `references/categories/finance.md`
- `report` -> генерация и получение отчётов -> `references/categories/report.md`
- `receipts` -> чеки -> `references/categories/receipts.md`
- `seller-rating` -> рейтинг продавца и индекс ошибок -> `references/categories/seller-rating.md`

## Machine Catalog

- `catalog/methods.json` -> полный каталог методов, wrapper'ов и source_title.
- `catalog/categories.json` -> краткий индекс по категориям.

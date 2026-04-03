# Claude Code Skills

Коллекция скиллов для [Claude Code](https://claude.ai/code) — AI-ассистента для разработчиков.

## Что такое скилл

Скилл — это директория с файлом `SKILL.md` (точка входа) и `references/` (детальные справочники по темам). Claude читает `SKILL.md` для ориентации, а reference-файлы подгружает по необходимости — не всё сразу.

## Установка

Скопируй директорию скилла в `~/.claude/skills/`:

```bash
git clone https://github.com/esporykhin/claude-code-skills.git
cp -r claude-code-skills/mpstats ~/.claude/skills/mpstats
```

Или создай симлинк (удобно для разработки):

```bash
ln -s /path/to/claude-code-skills/mpstats ~/.claude/skills/mpstats
```

## Доступные скиллы

### MPSTATS

Полный справочник по REST API MPSTATS для аналитики маркетплейсов.

**Покрывает:**
- Wildberries: рубрикатор, категории, ниши (предметы), бренды, продавцы, похожие товары, SKU-аналитика, прогнозы ИИ, сезонность
- Ozon: рубрикатор, категории, бренды, продавцы, SKU-аналитика
- Яндекс Маркет: категории, бренды, продавцы, SKU-аналитика
- Авторизация, лимиты, пагинация, фильтрация, сортировка
- Готовые bash-скрипты для вызова через Bash tool без написания кода

**Требования:**
- Предпочтительно: настрой `mpstats/config/.env` (инструкция в `mpstats/config/README.md`)
- Альтернатива: переменная окружения `MPSTATS_TOKEN` (переопределяет значение из `config/.env`)

**Структура:**
```
mpstats/
├── SKILL.md                       — точка входа, индекс, описание скриптов
├── config/
│   ├── .env.example               — шаблон для токена MPSTATS
│   └── README.md                  — как получить токен и сохранить его
├── scripts/                       — готовые bash-скрипты для вызова через Bash tool
│   ├── common.sh                  — общая логика загрузки токена из config/.env
│   ├── README.md                  — каталог скриптов и сценарии использования
│   ├── account/
│   │   └── account-limits.sh      — проверка остатка лимитов API
│   ├── wb/                        — WB-скрипты (категории, бренды, продавцы, SKU, ниши)
│   ├── ozon/                      — Ozon-скрипты (категории, бренды, продавцы, SKU)
│   ├── ym/                        — Яндекс Маркет (категории и SKU)
│   └── *.sh                       — compatibility wrappers для старых путей
└── references/
    ├── auth.md                    — авторизация, токены, лимиты
    ├── pagination-filter-sort.md  — пагинация, фильтры, сортировка
    ├── coverage.md                — покрытие endpoint-ов скриптами
    ├── wb-categories.md           — WB: категории, ниши (предметы), прогнозы
    ├── wb-brands-sellers.md       — WB: бренды и продавцы
    ├── wb-similar-sku.md          — WB: похожие товары, SKU-аналитика
    ├── ozon-categories.md         — Ozon: категории
    ├── ozon-brands-sellers-sku.md — Ozon: бренды, продавцы, SKU
    ├── ym-categories.md           — Яндекс Маркет: все эндпоинты
    └── account.md                 — аккаунт, остаток лимитов
```

**Активирующие слова:** MPSTATS API, Wildberries analytics, Ozon analytics, marketplace data, product research, sales analytics, competitor analysis, niche research, SKU data.

### Yandex Position Checker

Скилл для проверки позиций карточки организации на Яндекс Картах через endpoint `POST /api/tools/check-positions`.

**Покрывает:**
- Проверку позиций по ключевым запросам через `POST /api/tools/check-positions`
- Сценарий, совместимый с бесплатным чекером `https://loocl.ru/tools/position-checker`
- Ввод локации как координаты или адрес (с геокодированием)
- Готовые bash-скрипты для запуска проверки без ручной сборки JSON

**Требования:**
- Доступ к `https://loocl.ru` (или к совместимому домену)
- Опционально: переменная `YANDEX_POSITION_CHECKER_BASE_URL` (или строка в `~/.claude/credentials.env`)
- Обратная совместимость: `LOOCL_BASE_URL` тоже поддерживается
- Опционально: `YANDEX_GEOCODER_API_KEY` для более точного геокодирования адресов РФ
- Если пользователь просит проверку по конкретным адресам, рекомендуется запросить у него `YANDEX_GEOCODER_API_KEY` и запускать проверки с этим ключом

**Установка:**
```bash
cp -r claude-code-skills/yandex-position-checker ~/.claude/skills/yandex-position-checker
```

**Структура:**
```
yandex-position-checker/
├── SKILL.md                               — точка входа и сценарии использования
├── scripts/
│   ├── check-position.sh                  — универсальная проверка позиции
│   ├── check-position-free.sh             — формат входа как в бесплатном чекере
│   └── check-position-raw.sh              — отправка произвольного JSON в endpoint
└── references/
    ├── endpoint-check-positions.md        — контракт endpoint free checker
    └── free-checker-mapping.md            — маппинг полей free checker -> endpoint
```

**Активирующие слова:** yandex maps positions, checker позиций, геовыдача, local serp, position checker.

### Ozon Seller API

Скилл для операционной работы с Ozon Seller API.

**Покрывает:**
- Список товаров (`/v2/product/list`)
- Информацию о ценах (`/v4/product/info/prices`)
- Обновление остатков (`/v1/product/import/stocks`)
- Обновление цен (`/v1/product/import/prices`)
- Списки отправлений FBS/FBO (`/v3/posting/fbs/list`, `/v2/posting/fbo/list`)
- Список складов (`/v1/warehouse/list`)
- Список отчётов и детали отчёта (`/v1/report/list`, `/v1/report/info`)
- Raw-вызовы любого endpoint через общий скрипт

**Требования:**
- Переменные окружения `OZON_CLIENT_ID` и `OZON_API_KEY`
- Опционально: `OZON_SELLER_BASE_URL` (по умолчанию `https://api-seller.ozon.ru`)
- Альтернатива: добавить креды в `~/.claude/credentials.env`

**Установка:**
```bash
cp -r claude-code-skills/ozon-seller-api ~/.claude/skills/ozon-seller-api
```

**Структура:**
```
ozon-seller-api/
├── SKILL.md                                  — точка входа и маршрутизация сценариев
├── scripts/
│   ├── products-list.sh                      — список товаров
│   ├── product-prices.sh                     — цены товаров
│   ├── update-stocks.sh                      — обновление остатков
│   ├── update-prices.sh                      — обновление цен
│   ├── postings-fbs-list.sh                  — отправления FBS
│   ├── postings-fbo-list.sh                  — отправления FBO
│   ├── warehouses-list.sh                    — список складов
│   ├── report-list.sh                        — список отчётов
│   ├── report-info.sh                        — статус/детали отчёта
│   ├── request-raw.sh                        — произвольный запрос к endpoint
│   └── _common.sh                            — общая логика auth/base-url/request
└── references/
    ├── auth.md                               — авторизация, коды ошибок, источники
    ├── products-and-prices.md                — товары/цены/остатки
    └── postings-reports-warehouses.md        — отправления/отчёты/склады
```

**Активирующие слова:** Ozon Seller API, ozon products list, ozon price update, ozon stock update, fbs postings, fbo postings, ozon warehouses, ozon reports.

## Лицензия

MIT

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
- Установи переменную окружения `MPSTATS_TOKEN` или добавь строку `MPSTATS_TOKEN=<token>` в `~/.claude/credentials.env`

**Структура:**
```
mpstats/
├── SKILL.md                       — точка входа, индекс, описание скриптов
├── scripts/                       — готовые bash-скрипты для вызова через Bash tool
│   ├── account-limits.sh          — проверка остатка лимитов API
│   ├── wb-categories-list.sh      — дерево категорий WB
│   ├── wb-category.sh             — товары в категории WB
│   ├── wb-category-stats.sh       — разбивка по подкатегориям/брендам/продавцам WB
│   ├── wb-sku.sh                  — аналитика SKU WB (продажи, остатки, позиции)
│   ├── wb-brand.sh                — аналитика бренда WB
│   ├── wb-seller.sh               — аналитика продавца WB
│   ├── wb-search.sh               — список ниш/предметов WB
│   ├── ozon-categories-list.sh    — дерево категорий Ozon
│   ├── ozon-category.sh           — товары в категории Ozon
│   ├── ozon-sku.sh                — продажи SKU Ozon
│   ├── ozon-brand.sh              — аналитика бренда Ozon
│   ├── ozon-seller.sh             — аналитика продавца Ozon
│   ├── ym-category.sh             — товары в категории Яндекс Маркет
│   └── ym-sku.sh                  — продажи товара Яндекс Маркет
└── references/
    ├── auth.md                    — авторизация, токены, лимиты
    ├── pagination-filter-sort.md  — пагинация, фильтры, сортировка
    ├── wb-categories.md           — WB: категории, ниши (предметы), прогнозы
    ├── wb-brands-sellers.md       — WB: бренды и продавцы
    ├── wb-similar-sku.md          — WB: похожие товары, SKU-аналитика
    ├── ozon-categories.md         — Ozon: категории
    ├── ozon-brands-sellers-sku.md — Ozon: бренды, продавцы, SKU
    ├── ym-categories.md           — Яндекс Маркет: все эндпоинты
    └── account.md                 — аккаунт, остаток лимитов
```

**Активирующие слова:** MPSTATS API, Wildberries analytics, Ozon analytics, marketplace data, product research, sales analytics, competitor analysis, niche research, SKU data.

## Лицензия

MIT

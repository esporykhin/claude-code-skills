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
- Примеры кода на TypeScript и Python

**Структура:**
```
mpstats/
├── SKILL.md                       — точка входа, индекс
└── references/
    ├── auth.md                    — авторизация, токены, лимиты
    ├── pagination-filter-sort.md  — пагинация, фильтры, сортировка
    ├── wb-categories.md           — WB: категории, ниши (предметы), прогнозы
    ├── wb-brands-sellers.md       — WB: бренды и продавцы
    ├── wb-similar-sku.md          — WB: похожие товары, SKU-аналитика
    ├── ozon-categories.md         — Ozon: категории
    ├── ozon-brands-sellers-sku.md — Ozon: бренды, продавцы, SKU
    ├── ym-categories.md           — Яндекс Маркет: все эндпоинты
    ├── account.md                 — аккаунт, остаток лимитов
    └── code-examples.md           — примеры кода TypeScript/Python/cURL
```

**Активирующие слова:** MPSTATS API, Wildberries analytics, Ozon analytics, marketplace data, product research, sales analytics, competitor analysis, niche research, SKU data.

## Лицензия

MIT

# Claude Code Skills

Коллекция скиллов для [Claude Code](https://claude.ai/code). Каждый скилл — самодостаточный модуль с API-справочником и готовыми bash-скриптами. Агент подгружает скилл по контексту и сразу работает с API без написания кода.

## Скиллы

| Скилл | Что делает | API |
|-------|-----------|-----|
| [mpstats](./mpstats/) | Аналитика маркетплейсов: продажи, ниши, бренды, продавцы, SKU | [MPSTATS API](https://mpstats.io/integrations) |
| [ozon-seller-api](./ozon-seller-api/) | Управление товарами, ценами, остатками, отправлениями на Ozon | [Ozon Seller API](https://docs.ozon.ru/api/seller/) |

## Установка

```bash
git clone https://github.com/esporykhin/claude-code-skills.git

# Скопировать нужный скилл
cp -r claude-code-skills/mpstats ~/.claude/skills/mpstats
cp -r claude-code-skills/ozon-seller-api ~/.claude/skills/ozon-seller-api
```

После этого Claude Code автоматически подхватит скилл по контексту разговора.

## Как устроен скилл

```
skill-name/
├── SKILL.md          — точка входа, индекс, навигация (~200 строк)
├── scripts/          — bash-скрипты для вызова через Bash tool
├── references/       — детальные API-контракты (подгружаются по запросу)
└── config/           — токены и настройки
```

`SKILL.md` загружается в контекст целиком как индекс. Файлы из `references/` агент читает только по необходимости. Скрипты из `scripts/` агент вызывает напрямую. Такая структура не забивает контекст, но даёт быстрый доступ к любому методу API.

---

### MPSTATS

Полный справочник MPSTATS API для аналитики Wildberries, Ozon и Яндекс Маркет.

**122 эндпоинта, 30+ bash-скриптов.**

- Категории, ниши, бренды, продавцы — продажи, выручка, тренды, ценовая сегментация
- SKU-аналитика: история продаж, остатки по складам и размерам, позиции в поиске, отзывы
- Похожие товары, сравнение периодов, AI-прогнозы, сезонность
- Генерация аналитических отчётов в фирменном стиле MPSTATS

**Токен:** получить на [mpstats.io/userpanel](https://mpstats.io/userpanel), сохранить в `mpstats/config/.env`

---

### Ozon Seller API

Операционная работа с магазином на Ozon через Seller API.

- Список товаров и цен, обновление остатков и цен
- Отправления FBS/FBO, список складов, отчёты
- Raw-вызовы любого endpoint

**Ключи:** `OZON_CLIENT_ID` + `OZON_API_KEY` в переменных окружения или `~/.claude/credentials.env`

## Лицензия

MIT

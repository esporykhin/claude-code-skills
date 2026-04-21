# Claude Code Skills

Коллекция скиллов для [Claude Code](https://claude.ai/code). Каждый скилл — самодостаточный модуль с API-справочником и готовыми bash-скриптами. Агент подгружает скилл по контексту и сразу работает с API без написания кода.

## Скиллы

| Скилл | Что делает | API |
|-------|-----------|-----|
| [mpstats](./mpstats/) | Аналитика маркетплейсов: продажи, ниши, бренды, продавцы, SKU | [MPSTATS API](https://mpstats.io/integrations) |
| [ozon-seller-api](./ozon-seller-api/) | Полный каталог Ozon Seller API: 38 категорий, 409 bash-wrapper'ов, поиск методов и raw-вызовы | [Ozon Seller API](https://docs.ozon.ru/api/seller/) |
| [kaiten](./kaiten/) | Kaiten: карточки, доски, пространства, колонки, комментарии, пользователи, теги | [Kaiten API](https://developers.kaiten.ru) |

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
├── scripts/          — bash-скрипты, общий раннер и method wrappers
├── references/       — детальные API-контракты (подгружаются по запросу)
└── tests/            — e2e-smoke и локальный mock server
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

Полноценный skill для Ozon Seller API, собранный вокруг bash-first workflow и нормальной навигации по методам.

**38 категорий, 409 wrapper-скриптов, e2e smoke-тесты.**

- Каталог методов по категориям: товары, цены, остатки, FBS, FBO, FBP, отчёты, финансы, возвраты, чат, уведомления, Ozon Логистика, склады и служебные API
- Поиск метода через `scripts/ozon-find-method.sh`
- Универсальный raw-вызов через `scripts/ozon-request.sh`
- Точечные wrapper-скрипты в `scripts/methods/<category>/`
- E2E-проверка bash-слоя через `tests/e2e.sh`

**Ключи:** `OZON_CLIENT_ID` + `OZON_API_KEY` в переменных окружения или `~/.claude/credentials.env`

---

### Kaiten

Скилл для [Kaiten API](https://developers.kaiten.ru) — таск-трекера с канбан-досками.

**Покрыто:** карточки (CRUD, перемещение, комментарии, участники, теги, чеклисты), доски, колонки, дорожки, пространства, пользователи, произвольные запросы.

- Универсальный raw-вызов: `scripts/kaiten-request.sh`
- Готовые wrapper'ы: `scripts/methods/` (create/update/move карточки, список досок и колонок, комментарии)
- Справочник эндпоинтов: `references/api.md`

**Ключи:** `KAITEN_DOMAIN` (например `mycompany.kaiten.ru`) + `KAITEN_TOKEN` в переменных окружения или `~/.claude/credentials.env`. Токен: Kaiten → Профиль → API → Create new API token.

## Лицензия

MIT

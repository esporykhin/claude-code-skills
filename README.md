# claude-code-skills

Коллекция скиллов для Claude Code — готовые инструкции и справочники для разработчиков.

## Что такое скиллы Claude Code

Скиллы — это `.md` файлы, которые добавляются в `.claude/commands/` директорию проекта или `~/.claude/commands/` для глобального использования. После установки скилл вызывается slash-командой: `/имя-скилла`.

## Доступные скиллы

### `mpstats` — MPSTATS API Reference

Полный справочник по публичному REST API сервиса MPSTATS — платформы аналитики маркетплейсов Wildberries, Ozon и Яндекс Маркет.

**Что включено:**
- Авторизация и базовые параметры запросов
- Все эндпоинты Wildberries API (категории, ниши, бренды, продавцы, SKU, прогнозы)
- Все эндпоинты Ozon API
- Все эндпоинты Яндекс Маркет API
- Эндпоинты аккаунта (лимиты)
- Модели данных с описанием полей
- Примеры запросов на curl, TypeScript и Python

**Когда использовать:**
- Интеграция с MPSTATS API
- Разработка аналитических инструментов для WB/Ozon
- Работа с данными о товарах, продажах, категориях маркетплейсов

## Установка

### Для одного проекта

Скопируй нужный `.md` файл в директорию `.claude/commands/` в корне проекта:

```bash
mkdir -p .claude/commands
cp path/to/claude-code-skills/mpstats/mpstats.md .claude/commands/
```

После этого в Claude Code появится команда `/mpstats`.

### Глобально (для всех проектов)

Скопируй в `~/.claude/commands/`:

```bash
mkdir -p ~/.claude/commands
cp path/to/claude-code-skills/mpstats/mpstats.md ~/.claude/commands/
```

### Через git clone

```bash
git clone https://github.com/esporykhin/claude-code-skills
cp claude-code-skills/mpstats/mpstats.md ~/.claude/commands/
```

## Использование

После установки вызови скилл в Claude Code:

```
/mpstats
```

Claude получит полный контекст по MPSTATS API и сможет помочь с интеграцией без необходимости отдельно читать документацию.

## Лицензия

MIT

# Dokploy skill — конфигурация

## Как получить API-токен

1. Открой Dokploy UI → **Settings** → **API/CLI** (или **Profile → API**).
2. Жми **Generate Token** — токен показывается один раз, скопируй сразу.
3. Запиши также URL инстанса (например `http://212.67.12.194:3000`).

## Установка

### Вариант 1 — дать агенту (он сам настроит)

Передай агенту в чате `DOKPLOY_URL` и `DOKPLOY_API_KEY`. Агент создаст `config/.env`.

### Вариант 2 — руками

```bash
cp config/.env.example config/.env
# открой config/.env и впиши URL + токен
chmod 600 config/.env
```

## Альтернативы

- Переменные окружения: `DOKPLOY_URL=... DOKPLOY_API_KEY=... ./scripts/dokploy-request.sh ...` — переопределяют `config/.env` на один вызов.

## Проверка

```bash
./scripts/methods/project-list.sh
```

Должен вернуться JSON со списком проектов.

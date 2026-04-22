# Kaiten skill — конфигурация

## Как получить API-токен

1. Войди в Kaiten под нужным пользователем (токен действует от его имени).
2. Клик по аватару → **Профиль** → вкладка **API**.
3. **Create new API token**, скопируй значение.

Также запиши `KAITEN_DOMAIN` — хост инсталляции (например, `mycompany.kaiten.ru`, с протоколом или без).

## Установка

### Вариант 1 — дать агенту

Передай в чате `KAITEN_DOMAIN` + `KAITEN_TOKEN`. Агент создаст `config/.env` сам.

### Вариант 2 — руками

```bash
cp config/.env.example config/.env
# отредактируй KAITEN_DOMAIN и KAITEN_TOKEN
chmod 600 config/.env
```

## Альтернативы

- `KAITEN_DOMAIN=... KAITEN_TOKEN=... ./scripts/methods/current-user.sh` — env-переменные переопределяют `config/.env`.
- Файл `config/.env` в `.gitignore`, в git не попадёт.

## Проверка

```bash
./scripts/methods/current-user.sh
```

Должен вернуть JSON с твоим пользователем Kaiten.

# Projects & Environments

## Структура

```
Organization
  └── Project
        └── Environment (production | staging | preview)
              ├── applications[]
              ├── compose[]
              ├── postgres / mysql / redis / mongo / mariadb [...]
              └── ...
```

Application всегда живёт внутри Environment. Environment — внутри Project.

## `project.all` (GET)

Возвращает массив проектов с **раскрытыми** environments и сервисами:

```json
[
  {
    "projectId": "...",
    "name": "Loocl",
    "environments": [
      {
        "environmentId": "...",
        "name": "production",
        "applications": [{"applicationId":"...","name":"...","applicationStatus":"done"}],
        "compose": [...],
        "postgres": [...],
        "redis": [...]
      }
    ]
  }
]
```

## `project.create` (POST)

```json
{ "name": "MySite", "description": "..." }
```

Создаёт проект и автоматически дефолтный environment `production`.

Возвращает `{project, environment}` — оба нужны: project для отображения, environment для последующего создания приложений.

## `project.one` / `project.update` / `project.delete`

```bash
./scripts/dokploy-request.sh GET project.one --query 'projectId=...'
./scripts/dokploy-request.sh POST project.update --data '{"projectId":"...","name":"new"}'
./scripts/dokploy-request.sh POST project.delete --data '{"projectId":"..."}'
```

## Environments

`environment.create` — создать дополнительный environment в проекте:

```json
{ "projectId":"...", "name":"staging", "description":"..." }
```

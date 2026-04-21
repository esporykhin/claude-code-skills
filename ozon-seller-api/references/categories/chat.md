# Chat

- Category key: `chat`
- Methods in local catalog: `6`

## How To Use

1. Найди нужный метод по таблице ниже.
2. Если payload неочевиден, сверяйся с source doc или официальной документацией Ozon.
3. Запускай wrapper из колонки `script`.
4. Если wrapper есть, но нужно проверить wording или соседние методы, открой source markdown только для этого куска.

## Methods

| method | http | path | script | note |
|---|---|---|---|---|
| `sendFile` | `POST` | `/v1/chat/send/file` | `scripts/methods/chat/send-file.sh` | Отправить файл |
| `sendChatMessage` | `POST` | `/v1/chat/send/message` | `scripts/methods/chat/send-chat-message.sh` | Отправить сообщение |
| `startChat` | `POST` | `/v1/chat/start` | `scripts/methods/chat/start-chat.sh` | Создать новый чат |
| `markChatAsRead` | `POST` | `/v2/chat/read` | `scripts/methods/chat/mark-chat-as-read.sh` | Отметить сообщения как прочитанные |
| `getChatHistory` | `POST` | `/v3/chat/history` | `scripts/methods/chat/get-chat-history.sh` | История чата |
| `getChatListV3` | `POST` | `/v3/chat/list` | `scripts/methods/chat/get-chat-list-v3.sh` | Список чатов |

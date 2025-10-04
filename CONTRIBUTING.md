# 🤝 Contributing Guide

Спасибо, что хотите внести вклад в **Smart Home AI Orchestrator**!

---

## 🚀 Как начать
1. Сделайте форк репозитория
2. Создайте ветку для своей задачи:
   ```bash
   git checkout -b feature/my-feature
   ```
3. Внесите изменения и протестируйте:
   ```bash
   make build && make run
   make healthcheck
   ```
4. Создайте Pull Request, используя [шаблон](.github/pull_request_template.md)

---

## 📂 Структура проекта
- `compose/` — docker-compose файлы
- `make/` — Makefile и скрипты
- `omni/` — мультимодальный агент
- `node-red/` — готовые flow
- `docs/` — документация
- `.env.example` — переменные окружения

---

## 🧪 Тестирование
- Используйте `make test-image` и `make test-audio` для проверки Omni
- Проверяйте VRAM: `make vram`
- Следите за healthcheck: `make healthcheck`

---

## 📜 Правила
- Код оформляйте в едином стиле (Python: PEP8)
- Документацию пишите в Markdown
- Все новые функции должны сопровождаться обновлением README или docs/
- Перед PR убедитесь, что стек поднимается без ошибок

---

## 🙌 Благодарности
Каждый вклад ценен. Даже исправление опечатки в документации помогает проекту!
# Vita: Гибридная архитектура умного дома с локальным ИИ

**Vita** — это локальный ИИ‑ассистент, интегрированный в умный дом. Он работает полностью оффлайн, поддерживает зрение, голос, память и автоматизацию.

## Структура проекта

```
project_vita/
├── README.md
├── README_hybrid.md
├── docs/
│   └── architecture.md
├── compose/
│   └── llama.cpp.override.yml
├── models/
│   └── qwen3-7b-chat-q4_k_m.gguf
├── scripts/
│   └── llama_run.sh
└── .gitignore
```

## Основные компоненты

- **Гибридная архитектура**: Поддержка различных конфигураций оборудования
- **llama.cpp**: Локальный запуск LLM моделей
- **Документация**: Полное описание архитектуры и принципов работы
- **Docker Compose**: Конфигурации для развертывания сервисов

## Начало работы

1. Ознакомьтесь с [README_hybrid.md](README_hybrid.md) для понимания архитектуры
2. Изучите [docs/architecture.md](docs/architecture.md) для деталей взаимодействия компонентов
3. Используйте [scripts/llama_run.sh](scripts/llama_run.sh) для запуска модели
4. Настройте [compose/llama.cpp.override.yml](compose/llama.cpp.override.yml) для Docker окружения

## Принципы Vita

- **Локальность**: всё работает без интернета
- **Модульность**: легко масштабировать и адаптировать
- **Открытость**: open‑source, документация, инструкции
- **Доступность**: работает на бюджетных платформах

## 🛠️ Поддерживаемые конфигурации

Проект поддерживает различные конфигурации оборудования благодаря гибридной архитектуре Vita. Подробнее о поддерживаемых сборках и конфигурациях читайте в [README_hybrid.md](README_hybrid.md).

GPU-ускорение является опциональным и поддерживается на платформах с соответствующим оборудованием. Система может работать в режиме CPU-only или с использованием edge-модулей.

---

## ⚙️ Сервисы и роли

| Сервис         | Назначение                         | GPU-ускорение |
|----------------|------------------------------------|---------------|
| Home Assistant | Центр управления                   | ❌            |
| Frigate        | Видеоаналитика (камеры, события)   | ✅            |
| Ollama         | Локальный LLM (логика, диалоги)    | ✅            |
| Whisper        | Распознавание речи (STT)           | ✅            |
| Piper          | Озвучивание ответов (TTS)          | ❌            |
| Jellyfin       | Медиасервер, стриминг, DLNA        | ✅            |
| Samba          | NAS-доступ по SMB                  | ❌            |
| Portainer      | Управление контейнерами            | ❌            |
| Telegraf       | Сбор системных метрик              | ❌            |
| InfluxDB       | Хранилище метрик от Telegraf       | ❌            |
| Prometheus     | Хранилище метрик от DCGM Exporter  | ❌            |
| DCGM Exporter  | Мониторинг RTX 4090                | ✅            |
| Grafana        | Визуализация метрик и дашборды     | ❌            |

---

## 🧠 Взаимодействие сервисов

- Frigate → события → Home Assistant  
- Home Assistant → запрос → Ollama → ответ  
- Голос → Whisper → текст → Ollama → Piper → звук  
- Telegraf → InfluxDB → Grafana  
- DCGM Exporter → Prometheus → Grafana  
- Jellyfin → стриминг мультимедиа с NVENC  
- Samba → сетевой доступ к файлам

### 🧠 Omni-модуль

В стек интегрирован **Qwen3-Omni** — мультимодальный агент, способный обрабатывать:
- текстовые запросы,
- изображения (например, snapshot от Frigate),
- аудио (голосовые команды).

Omni запускается по событию и может быть адаптирован под различные конфигурации оборудования.

---

## 📦 Хранилище

| Диск           | Роль                            | Монтирование         |
|----------------|----------------------------------|----------------------|
| SSD 2 TB       | Система, Docker, AI              | /mnt/system          |
| HDD #1 4 TB    | Мультимедиа, NAS-файлы           | /mnt/media           |
| HDD #2 4 TB    | Резервные копии (BorgBackup)     | /mnt/backup          |
| HDD #3 4 TB    | SnapRAID-паритет                 | /mnt/parity          |

---

## 📊 Мониторинг

- Telegraf: CPU, RAM, диски, сеть, контейнеры  
- DCGM Exporter: температура, загрузка, VRAM RTX 4090  
- Grafana: дашборды, уведомления  
- Prometheus: метрики GPU

---

## 🗣️ Голосовой помощник

- Whisper → STT  
- Ollama → логика  
- Piper → TTS  
- Home Assistant → маршрутизация  
- Возможность диалогов, команд, сценариев

---

## 📁 Docker Compose

Все сервисы объединены в `docker-compose.yaml`, включая конфигурации Telegraf и Prometheus. Поддержка GPU является опциональной и может быть включена через `docker-compose.override.yml`.

---

## 📈 Расширения

- Immich — фотоархив с AI  
- Nextcloud — облако и документы  
- Node-RED — визуальная логика  
- Telegram Alerts — уведомления  
- Watchtower — автообновление контейнеров

---

## 🧠 Принцип

Максимальная автономность, локальный ИИ, визуальное управление, защита данных, гибкость и масштабируемость.
---

## 📚 Дополнительные материалы

- [📝 Limitations & Caveats](docs/limitations.md)
- [🔮 Roadmap & Future Plans](docs/roadmap.md)
- [📜 Rule Engine Specification](docs/automation-spec.md)
- [🗃️ Automation DB Schema](docs/automation-db-schema.md)
- [🧪 Load Testing Plan](docs/automation-loadtest.md)
- [🧠 Omni Module Documentation](docs/omni-module.md)
- [🎙️ Voice Assistant](docs/voice-assistant.md)
- [🛠️ Makefile Guide](docs/makefile-guide.md)

- ### 🧠 Сравнение моделей Qwen3‑Omni и Qwen2.5‑Omni

- ВНИМАНИЕ!
  🔗 Qwen3‑Omni‑14B (AWQ) — доступна через vLLM и ModelScope  
📁 Модель загружается вручную: `Qwen/Qwen3-Omni-14B-AWQ`  
⚠️ Не опубликована на Hugging Face, используется в локальных сборках



| Характеристика             | Qwen3‑Omni‑14B                                                                 | Qwen2.5‑Omni (72B)                                                                 |
|----------------------------|--------------------------------------------------------------------------------|------------------------------------------------------------------------------------|
| Размер модели              | 14B                                                                            | 72B                                                                                |
| Мультимодальность          | ✅ Текст, изображение, аудио                                                   | ✅ Текст, изображение, аудио                                                       |
| Поддержка аудио            | ✅                                                                              | ✅                                                                                 |
| Поддержка изображений      | ✅                                                                              | ✅                                                                                 |
| Совместимость              | [vLLM](https://github.com/vllm-project/vllm), [AWQ](https://github.com/mit-han-lab/awq), Docker | [HuggingFace Transformers](https://github.com/QwenLM/Qwen2.5-Omni)                |
| Запуск на RTX 4090         | ✅ Полностью совместима                                                       | ⚠️ Требуется 2× RTX 4090 или A100                                                  |
| VRAM‑потребление           | ~22–24 ГБ                                                                      | ~48–80 ГБ                                                                          |
| Скорость отклика           | ⚡ Быстрая (AWQ + vLLM)                                                         | 🧠 Медленнее, требует больше ресурсов                                              |
| Подходит для локального ИИ | ✅ Да                                                                          | ⚠️ Только при наличии дата‑центра или нескольких GPU                               |
| Статус                     | Проверена в продакшн‑стеке                                                    | Новая, экспериментальная                                                          |

> 💡 **Почему выбрана Qwen3‑Omni**:  
> Она идеально подходит для домашнего сервера с одной RTX 4090, полностью совместима с vLLM и Docker, и уже интегрирована в стек.  
> Qwen2.5‑Omni — это следующий шаг для масштабирования, но требует гораздо больше ресурсов.



![Yuri's AI-Powered Docker Server Architecture]([https://github.com/TrueTaragane/smart-home-architecture/blob/main/githubusercontent.png](https://github.com/TrueTaragane/project_vita/blob/main/githubusercontent.png)?raw=true)



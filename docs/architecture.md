# Архитектура Vita

## Общая схема

```
[Edge-модули] → MQTT / REST → [Центральный узел (Vita)] → Ответ → TTS / HA / Telegram
```

## Компоненты

- **Центральный узел**: mini‑PC или ноутбук с llama.cpp / AirLLM
- **Зрение**: Frigate, YOLO, CLIP — работает на Orange Pi / Jetson
- **Голос**: Whisper, Silero TTS — локальные модели
- **Память**: SQLite / JSON / RAM‑кеш
- **Автоматизация**: Home Assistant, Node‑RED

## Пример взаимодействия

1. Frigate обнаруживает движение → MQTT
2. Vita получает событие → llama.cpp генерирует ответ
3. Ответ отправляется в Home Assistant → TTS озвучивает
#!/bin/bash
# Скрипт автоматического развертывания домашнего сервера (Debian/Ubuntu)

# 📜 Логирование в файл
exec > >(tee -i deploy_log.txt)
exec 2>&1

echo "🚀 --- Начинаем развертывание универсального сервера ---"

# 🔍 Проверка запуска из корня проекта
if [ ! -f "docker/docker-compose.yaml" ]; then
  echo "❌ Скрипт должен запускаться из корневой директории проекта, где лежит docker/docker-compose.yaml"
  exit 1
fi

# 🔍 Проверка наличия ключевых утилит
for cmd in curl docker docker-compose nvidia-smi; do
  if ! command -v $cmd &> /dev/null; then
    echo "❌ Команда '$cmd' не найдена. Установите её перед запуском."
    exit 1
  fi
done

# 🔍 Проверка конфигурационных файлов
echo "🔍 Проверка конфигурационных файлов..."
for file in docker/docker-compose.yaml monitoring/prometheus.yml monitoring/telegraf.conf; do
  if [ ! -f "$file" ]; then
    echo "❌ Не найден файл: $file"
    exit 1
  fi
done

# --- 1. Обновление системы и установка необходимых пакетов ---
echo "📦 1. Обновление пакетов и установка curl/gnupg..."
sudo apt update
sudo apt upgrade -y
sudo apt install -y curl gnupg software-properties-common

# --- 2. Установка Docker и Docker Compose ---
echo "🐳 2. Установка Docker Engine и Docker Compose V2..."
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo rm get-docker.sh

echo "👤 Добавление пользователя '$USER' в группу docker..."
sudo usermod -aG docker "$USER"
echo "⚠️ Выйдите и войдите в систему после завершения, чтобы изменения вступили в силу."

# --- 3. Установка NVIDIA Container Toolkit ---
echo "🎮 3. Установка NVIDIA Container Toolkit для RTX 4090..."
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list | \
  sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
  sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

sudo apt update
sudo apt install -y nvidia-container-toolkit

echo "🔁 Перезапуск Docker для применения настроек NVIDIA..."
sudo systemctl restart docker

echo "🧪 Проверка GPU-доступности..."
nvidia-smi || echo "⚠️ GPU не обнаружен или драйвер не установлен."

# --- 4. Создание структуры папок ---
echo "📁 4. Создание необходимых папок..."
BASE_DIR="/home/docker"
STORAGE_DIR="/home/storage"

mkdir -p "$BASE_DIR"/{homeassistant,frigate,ollama,portainer,telegraf,influxdb,prometheus,grafana,jellyfin}
mkdir -p "$STORAGE_DIR"/{media}

echo "⚠️ Убедитесь, что конфигурационные файлы скопированы в соответствующие папки:"
echo "  - prometheus.yml → $BASE_DIR/prometheus/"
echo "  - telegraf.conf  → $BASE_DIR/telegraf/"

# --- 5. Запуск стека Docker Compose ---
echo "🚦 5. Запуск всех сервисов через Docker Compose..."
docker compose -f docker/docker-compose.yaml up -d

# --- Завершение ---
echo "✅ --- Развертывание завершено! ---"
echo "📦 Проверить статус контейнеров: docker ps"
echo "🎛️ Portainer: http://localhost:9000"
echo "📊 Grafana:   http://localhost:3000"
echo "⚠️ Выйдите и войдите в систему, чтобы изменения группы Docker вступили в силу."

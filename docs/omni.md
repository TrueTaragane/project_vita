# Omni Module Documentation

## 🧠 Overview

The Omni Module is the multimodal AI agent at the heart of the Vita system, powered by Qwen3-Omni. It processes text, images, and audio inputs to provide intelligent responses and automate home operations.

## 🏗️ Architecture

Архитектура Omni модуля состоит из следующих компонентов:

1. **Input Sources** - источники входных данных (текст, аудио, изображения)
2. **Preprocessing** - предварительная обработка данных
3. **Format Conversion** - преобразование форматов данных
4. **Model Inference** - инференс модели Qwen3-Omni
5. **Post-processing** - постобработка результатов
6. **Response Generation** - генерация ответа
7. **Action Execution** - выполнение действий

Данные проходят через все этапы обработки, начиная с входных источников и заканчивая выполнением действий в системе умного дома.

## 🔧 API Endpoints

### Text Processing
```json
POST /api/omni/text
Content-Type: application/json

{
  "prompt": "What's the temperature in the living room?",
  "context": "user_query",
  "max_tokens": 512
}

Response:
{
  "response": "The living room temperature is currently 22.5°C.",
  "confidence": 0.95,
  "processing_time": 1.2
}
```

### Image Processing
```json
POST /api/omni/image
Content-Type: multipart/form-data

{
  "image": "base64_encoded_image_data",
  "prompt": "What do you see in this image?"
}

Response:
{
  "response": "I see a living room with a sofa, coffee table, and television.",
  "objects_detected": ["sofa", "table", "television"],
  "confidence": 0.89,
  "processing_time": 2.1
}
```

### Audio Processing
```json
POST /api/omni/audio
Content-Type: audio/wav

[WAV audio data]

Response:
{
  "transcription": "What's the weather like today?",
  "response": "Today will be sunny with a high of 25°C.",
  "confidence": 0.92,
  "processing_time": 1.8
}
```

### Multimodal Processing
```json
POST /api/omni/multimodal
Content-Type: application/json

{
  "text": "What's in this image?",
  "image": "base64_encoded_image_data",
  "context": "visual_query"
}

Response:
{
  "response": "The image shows a kitchen with modern appliances.",
  "objects_detected": ["refrigerator", "oven", "microwave"],
  "confidence": 0.91,
  "processing_time": 2.5
}
```

## 🎯 Features

### Natural Language Understanding
- Context-aware responses
- Multi-turn conversations
- Intent recognition
- Entity extraction

### Computer Vision
- Object detection and classification
- Scene understanding
- Activity recognition
- Text extraction from images

### Audio Processing
- Speech-to-text transcription
- Speaker identification
- Audio event detection
- Noise reduction

### Home Automation Integration
- Device control commands
- Status queries
- Scene activation
- Rule creation assistance

## ⚙️ Configuration

### Model Settings
```yaml
model:
  name: "Qwen3-Omni-14B-AWQ"
  quantization: "AWQ"
  context_length: 8192
  gpu_layers: 35
  temperature: 0.7
  top_p: 0.9
```

### Performance Tuning
```yaml
performance:
  batch_size: 1
  max_tokens: 512
  gpu_memory_utilization: 0.85
  tensor_parallel_size: 1
```

### Integration Settings
```yaml
integration:
  home_assistant:
    url: "http://home-assistant:8123"
    token: "your_token_here"
  frigate:
    url: "http://frigate:5000"
  mqtt:
    broker: "mqtt://mosquitto:1883"
```

## 🧪 Testing

### Unit Tests
```python
def test_text_processing():
    response = omni.process_text("What time is it?")
    assert "time" in response.lower()
    assert response.confidence > 0.8

def test_image_processing():
    image_data = load_test_image()
    response = omni.process_image(image_data, "Describe this image")
    assert len(response.objects_detected) > 0
```

### Integration Tests
```python
def test_home_assistant_integration():
    response = omni.query_device_status("living_room_temperature")
    assert "temperature" in response
    assert isinstance(float(response.split()[-1]), float)
```

## 📊 Monitoring

### Health Checks
```json
GET /api/omni/health

Response:
{
  "status": "healthy",
  "model_loaded": true,
  "gpu_available": true,
  "memory_usage": "75%",
  "last_query": "2025-10-04T15:30:00Z"
}
```

### Performance Metrics
- Query processing time
- Model inference time
- Memory utilization
- GPU utilization
- Error rates

## 🔒 Security

### Authentication
- API key authentication
- JWT token validation
- Rate limiting
- IP whitelisting

### Data Protection
- Encryption in transit (TLS)
- Secure model storage
- Privacy-preserving processing
- Audit logging

## 🚀 Deployment

### Docker Configuration
```yaml
services:
  omni:
    build:
      context: ./omni
      dockerfile: Dockerfile.qwen3-omni
    container_name: qwen3-omni
    restart: unless-stopped
    runtime: nvidia
    ports:
      - "11437:11437"
    volumes:
      - ./models:/app/model
      - ./inputs:/app/inputs
    environment:
      - NVIDIA_VISIBLE_DEVICES=all
      - CUDA_VISIBLE_DEVICES=0
```

### Kubernetes Deployment
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: omni-module
spec:
  replicas: 1
  selector:
    matchLabels:
      app: omni
  template:
    metadata:
      labels:
        app: omni
    spec:
      containers:
      - name: omni
        image: vllm/vllm-openai:latest
        resources:
          limits:
            nvidia.com/gpu: 1
```
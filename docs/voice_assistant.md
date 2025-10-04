# Voice Assistant

## 🗣️ Overview

The Vita Voice Assistant provides hands-free control of your smart home through natural language interactions. It uses a pipeline of specialized models to convert speech to text, process queries, and generate spoken responses.

## 🏗️ Architecture

```
[Microphone] → [Whisper STT] → [Qwen3-Omni] → [Piper TTS] → [Speaker]
     |              |              |              |              |
  Audio Input   Text Output   AI Processing   Audio Output   Audio Output
```

## 🔧 Pipeline Components

### 1. Speech-to-Text (Whisper)
- **Model**: faster-whisper (large-v3)
- **Languages**: Multilingual support
- **Features**: 
  - Real-time transcription
  - Speaker diarization
  - Noise reduction
  - Punctuation restoration

### 2. AI Processing (Qwen3-Omni)
- **Model**: Qwen3-Omni-14B (AWQ quantized)
- **Capabilities**:
  - Natural language understanding
  - Home automation command processing
  - Context-aware responses
  - Multi-turn conversations

### 3. Text-to-Speech (Piper)
- **Model**: Piper TTS (ru_RU-irina-medium)
- **Languages**: Russian, English, German
- **Features**:
  - Low-latency synthesis
  - Emotion control
  - Prosody adjustment
  - Streaming output

## 🎯 Features

### Voice Commands
- **Device Control**: "Turn on the living room lights"
- **Status Queries**: "What's the temperature in the bedroom?"
- **Scene Activation**: "Good morning" (activate morning scene)
- **Media Control**: "Play jazz music in the kitchen"

### Wake Word Detection
- **Default**: "Vita" or "Ассистент"
- **Custom**: User-defined wake words
- **Sensitivity**: Adjustable detection threshold
- **False Trigger**: Machine learning-based filtering

### Multi-user Support
- **Voice Profiles**: Individual voice recognition
- **Preferences**: Personalized responses
- **Permissions**: User-specific access control
- **Privacy**: Separate data storage

### Offline Operation
- **Local Models**: All processing on-premises
- **No Cloud**: Zero internet dependency
- **Privacy**: No external data transmission
- **Reliability**: Network outage resilience

## ⚙️ Configuration

### Audio Settings
```yaml
audio:
  input_device: "default"
  output_device: "default"
  sample_rate: 16000
  chunk_size: 1024
  volume_threshold: 0.01
```

### Wake Word Configuration
```yaml
wake_word:
  model: "snowboy"
  sensitivity: 0.5
  audio_gain: 1.0
  apply_frontend: false
```

### Language Settings
```yaml
language:
  stt: "ru"
  llm: "ru"
  tts: "ru"
  fallback: "en"
```

### Processing Pipeline
```yaml
pipeline:
  stt_timeout: 5.0
  llm_timeout: 10.0
  tts_timeout: 5.0
  max_context_length: 1024
```

## 📋 Supported Commands

### Home Automation
- **Lighting**: "Turn on/off lights", "Set brightness to 50%"
- **Climate**: "Set temperature to 22 degrees", "Turn on heating"
- **Security**: "Arm security system", "Show front door camera"
- **Entertainment**: "Play music", "Pause TV", "Volume up"

### Information Queries
- **Weather**: "What's the weather today?"
- **Time**: "What time is it?", "Set a timer for 10 minutes"
- **Calendar**: "What's on my schedule today?"
- **Knowledge**: "Who is the president of Russia?"

### Scenes and Routines
- **Morning**: "Good morning" (activate morning scene)
- **Evening**: "Good evening" (activate evening scene)
- **Sleep**: "Good night" (activate sleep scene)
- **Custom**: User-defined routines

## 🧪 Testing

### Voice Recognition Tests
```python
def test_wake_word_detection():
    audio = generate_test_wake_word("Vita")
    result = voice_assistant.detect_wake_word(audio)
    assert result == True

def test_stt_accuracy():
    audio = generate_test_speech("What time is it?")
    transcription = voice_assistant.transcribe(audio)
    assert "time" in transcription.lower()
```

### Command Processing Tests
```python
def test_command_execution():
    command = "Turn on the living room lights"
    result = voice_assistant.process_command(command)
    assert result.success == True
    assert result.action == "light_on"
```

## 📊 Monitoring

### Performance Metrics
- **Latency**: End-to-end processing time
- **Accuracy**: Speech recognition accuracy
- **Response Time**: AI processing time
- **Resource Usage**: CPU, memory, GPU utilization

### Quality Metrics
- **Wake Word Detection**: True/false positive rates
- **STT Accuracy**: Word error rate
- **Command Success**: Successful execution rate
- **User Satisfaction**: Response quality ratings

## 🔧 Troubleshooting

### Common Issues

#### No Audio Input
- Check microphone connection
- Verify audio device settings
- Test with system audio tools
- Adjust volume threshold

#### Wake Word Not Detected
- Speak clearly and at appropriate volume
- Adjust sensitivity settings
- Retrain wake word model
- Check for background noise

#### Slow Responses
- Monitor system resource usage
- Reduce model complexity
- Enable GPU acceleration
- Optimize Docker configuration

#### Audio Quality Issues
- Check speaker connections
- Adjust audio gain settings
- Update audio drivers
- Test with different audio devices

## 🔒 Security

### Privacy Features
- **Local Processing**: No cloud transmission
- **Data Encryption**: Encrypted storage
- **Access Control**: User authentication
- **Audit Logging**: Command history

### Best Practices
- Regular security updates
- Strong password policies
- Network segmentation
- Regular backups
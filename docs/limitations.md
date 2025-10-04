# Limitations & Caveats

## 🚧 Known Limitations

### Hardware Dependencies
- **GPU Memory Requirements**: RTX 4090 (24GB VRAM) recommended for Qwen3-Omni-14B
- **RAM Requirements**: Minimum 64GB RAM for optimal performance with multiple services
- **Storage Requirements**: Minimum 2TB NVMe SSD for system and AI models

### Model Constraints
- **Qwen3-Omni Limitations**:
  - Context window: 8192 tokens
  - Multimodal inputs require preprocessing
  - Audio processing limited to specific formats
- **Frigate Constraints**:
  - Maximum 8 simultaneous camera streams on RTX 4090
  - Object detection accuracy varies with lighting conditions

### Network Considerations
- **Latency**: Local processing eliminates internet latency but depends on hardware
- **Bandwidth**: High-resolution video streams require significant local network bandwidth
- **MQTT Broker**: Single point of failure if not configured with redundancy

### Performance Trade-offs
- **Real-time Processing**: Some AI models may introduce processing delays
- **Battery Life**: Edge devices (Orange Pi, Jetson) have limited battery operation
- **Thermal Management**: High GPU utilization requires adequate cooling

## ⚠️ Caveats

### Setup Complexity
- Initial configuration requires technical expertise
- GPU driver installation can be challenging on some Linux distributions
- Model downloading and quantization requires significant time and bandwidth

### Maintenance Considerations
- Regular updates required for security patches
- Model updates may require re-quantization
- Backup strategies essential for production deployments

### Cost Factors
- High-end GPU significantly increases initial investment
- NVMe SSDs for large models add to system cost
- Enterprise-grade networking equipment recommended for multiple cameras

## 🔄 Workarounds and Mitigations

### Resource Optimization
- Use model quantization (Q4_K_M) to reduce memory requirements
- Implement service scaling based on demand
- Use CPU fallback for non-critical tasks

### Reliability Improvements
- Implement redundant MQTT brokers for critical deployments
- Use snapshot retention policies to manage storage
- Configure automated failover for essential services

### Cost Reduction Strategies
- Consider used GPU market for initial setup
- Use edge devices for preprocessing to reduce central processing load
- Implement tiered storage (SSD for active models, HDD for archives)
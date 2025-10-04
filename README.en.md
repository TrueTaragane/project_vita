# 🧠 Smart Home Architecture — Ryzen 7 7800X3D + RTX 4090

## 🎯 Goal
To build a local, autonomous, high-performance smart home system with voice control, video analytics, media streaming, monitoring, and on-device AI — all inside a compact server.

---

## 🛠️ Hardware Setup

### 🔹 CPU
- AMD Ryzen 7 7800X3D  
- 8 cores / 16 threads  
- High performance per watt  
- Ideal for Docker, Home Assistant, AI inference

### 🔹 GPU
- NVIDIA RTX 4090  
- 24 GB VRAM  
- Used by Frigate, Ollama, Jellyfin  
- Supports DCGM Exporter for GPU monitoring

### 🔹 Cooling
- 360mm liquid cooling (DeepCool LT720 / Arctic Liquid Freezer II / be quiet! Silent Loop 2)  
- Quiet under load  
- GPU uses stock RTX 4090 cooler

### 🔹 Case
- Fractal Design Meshify 2 / be quiet! Pure Base 500 FX  
- Excellent airflow  
- Supports 360mm radiator  
- Space for 3–4 HDDs + 2 SSDs

### 🔹 Power Supply
- Seasonic Focus GX 1000W / be quiet! Dark Power 13 1000W  
- 80+ Gold/Platinum certified  
- Handles RTX 4090 and sustained load

### 🔹 Storage
- NVMe SSD Gen4 2 TB — system, Docker, AI workloads  
- SATA SSD 4 TB — photo archive, Immich, Nextcloud  
- HDD 3×4 TB — media, backups, SnapRAID parity

### 🔹 Networking
- Intel i225-V 2.5G LAN / Realtek RTL8125B  
- Jumbo Frames support  
- Connected to Keenetic / MikroTik router  
- VLAN, QoS, Wake-on-LAN

---

## ⚙️ Services and Roles

| Service         | Purpose                            | GPU Acceleration |
|-----------------|-------------------------------------|------------------|
| Home Assistant  | Central control hub                 | ❌               |
| Frigate         | Video analytics (cameras, events)   | ✅               |
| Ollama          | Local LLM (logic, dialogs)          | ✅               |
| Whisper         | Speech-to-text (STT)                | ✅               |
| Piper           | Text-to-speech (TTS)                | ❌               |
| Jellyfin        | Media server, streaming, DLNA       | ✅               |
| Samba           | NAS access via SMB                  | ❌               |
| Portainer       | Container management                | ❌               |
| Telegraf        | System metrics collection           | ❌               |
| InfluxDB        | Metrics storage from Telegraf       | ❌               |
| Prometheus      | Metrics storage from DCGM Exporter  | ❌               |
| DCGM Exporter   | RTX 4090 monitoring                 | ✅               |
| Grafana         | Dashboards and visualization        | ❌               |

---

## 🧠 Service Interactions

- Frigate → events → Home Assistant  
- Home Assistant → query → Ollama → response  
- Voice → Whisper → text → Ollama → Piper → audio  
- Telegraf → InfluxDB → Grafana  
- DCGM Exporter → Prometheus → Grafana  
- Jellyfin → media streaming with NVENC  
- Samba → network file access

### 🧠 Omni Module

The stack integrates **Qwen3-Omni** — a multimodal agent capable of processing:
- text queries,
- images (e.g., snapshots from Frigate),
- audio (voice commands).

Omni is triggered by events and optimized for RTX 4090 (24 GB VRAM).

---

## 📦 Storage Layout

| Disk           | Role                          | Mount Point       |
|----------------|-------------------------------|-------------------|
| SSD 2 TB       | System, Docker, AI workloads  | /mnt/system       |
| HDD #1 4 TB    | Media, NAS files              | /mnt/media        |
| HDD #2 4 TB    | Backups (BorgBackup)          | /mnt/backup       |
| HDD #3 4 TB    | SnapRAID parity               | /mnt/parity       |

---

## 📊 Monitoring

- Telegraf: CPU, RAM, disks, network, containers  
- DCGM Exporter: temperature, load, VRAM of RTX 4090  
- Grafana: dashboards and alerts  
- Prometheus: GPU metrics

---

## 🗣️ Voice Assistant

- Whisper → STT  
- Ollama → logic  
- Piper → TTS  
- Home Assistant → routing  
- Supports dialogs, commands, scenarios

---

## 📁 Docker Compose

All services are defined in `docker-compose.yaml`, including GPU passthrough, Docker socket, Telegraf and Prometheus configs.

---

## 📈 Extensions

- Immich — AI-powered photo archive  
- Nextcloud — personal cloud and documents  
- Node-RED — visual automation logic  
- Telegram Alerts — notifications  
- Watchtower — automatic container updates

---

## 🧠 Philosophy

Maximum autonomy, local AI, visual control, data protection, flexibility, and scalability.

---

## 📚 Additional Materials

- [📝 Limitations & Caveats](docs/limitations.md)
- [🔮 Roadmap & Future Plans](docs/roadmap.md)
- [🧠 Omni Module Documentation](docs/omni-module.en.md)
- [🎙️ Voice Assistant](docs/voice-assistant.en.md)
- [🛠️ Makefile Guide](docs/makefile-guide.en.md)

- ### 🧠 Comparison: Qwen3‑Omni vs Qwen2.5‑Omni
> ⚠️ Qwen3‑Omni‑14B is not officially hosted on Hugging Face.  
> It is available via vLLM-compatible AWQ format from community sources.



| Feature                     | Qwen3‑Omni‑14B                                                             | Qwen2.5‑Omni (72B)                                                                  |
|----------------------------|----------------------------------------------------------------------------|-------------------------------------------------------------------------------------|
| Model size                 | 14B                                                                        | 72B                                                                                 |
| Multimodal capabilities     | ✅ Text, image, audio                                                      | ✅ Text, image, audio                                                               |
| Audio support               | ✅                                                                          | ✅                                                                                  |
| Image support               | ✅                                                                          | ✅                                                                                  |
| Compatibility               | [vLLM](https://github.com/vllm-project/vllm), [AWQ](https://github.com/mit-han-lab/awq), Docker | [HuggingFace Transformers](https://github.com/QwenLM/Qwen2.5-Omni)                 |
| Runs on RTX 4090            | ✅ Fully compatible                                                        | ⚠️ Requires 2× RTX 4090 or A100                                                     |
| VRAM usage                  | ~22–24 GB                                                                  | ~48–80 GB                                                                           |
| Response speed              | ⚡ Fast (AWQ + vLLM)                                                        | 🧠 Slower, higher resource demand                                                   |
| Suitable for local AI       | ✅ Yes                                                                     | ⚠️ Only with datacenter-grade hardware                                              |
| Stability                   | Proven in production stack                                                 | New, experimental                                                                  |

> 💡 **Why Qwen3‑Omni was chosen**:  
> It’s ideal for a single RTX 4090 setup, fully compatible with vLLM and Docker, and already integrated into the architecture.  
> Qwen2.5‑Omni is a next-generation model for scaling, but requires significantly more resources.


![Yuri's AI-Powered Docker Server Architecture](https://github.com/TrueTaragane/smart-home-architecture/blob/main/githubusercontent.png?raw=true)

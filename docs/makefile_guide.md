# Makefile Guide

## 📋 Overview

The Vita Makefile provides a set of convenient commands for managing the smart home system, including setup, deployment, maintenance, and development tasks. It simplifies complex operations into simple one-line commands.

## 🎯 Quick Start

### Initial Setup
```bash
# Clone repository and set up environment
make setup

# Install all dependencies
make install

# Start all services
make up
```

### Daily Operations
```bash
# Check system status
make status

# View logs
make logs

# Stop all services
make down
```

## 📋 Available Commands

### Setup and Installation
```bash
# Complete initial setup
make setup

# Install system dependencies
make install

# Update to latest version
make update

# Clean installation (removes all data)
make clean
```

### Service Management
```bash
# Start all services
make up

# Start services in detached mode
make up-detached

# Stop all services
make down

# Restart all services
make restart

# Start specific service
make start-service SERVICE=home-assistant

# Stop specific service
make stop-service SERVICE=frigate
```

### Development Commands
```bash
# Build all containers
make build

# Build specific container
make build-service SERVICE=omni

# Rebuild containers without cache
make rebuild

# Run tests
make test

# Run specific test suite
make test-suite SUITE=integration
```

### Maintenance Commands
```bash
# Backup system data
make backup

# Restore from backup
make restore BACKUP_FILE=backup_20251004.tar.gz

# Update system images
make update-images

# Clean unused Docker resources
make docker-clean

# Prune Docker volumes
make docker-prune
```

### Monitoring and Debugging
```bash
# View all logs
make logs

# View specific service logs
make logs-service SERVICE=omni

# Stream logs in real-time
make logs-follow

# View system metrics
make metrics

# Check service health
make health
```

### AI Model Management
```bash
# Download required models
make download-models

# Quantize models for efficiency
make quantize-models

# Update models to latest versions
make update-models

# Validate model integrity
make validate-models
```

## 🔧 Detailed Command Descriptions

### Setup Commands

#### `make setup`
Performs complete initial setup:
- Clones repository if needed
- Creates required directories
- Sets up environment variables
- Installs system dependencies

#### `make install`
Installs all required software dependencies:
- Docker and Docker Compose
- GPU drivers (if applicable)
- Python dependencies
- System utilities

#### `make update`
Updates the system to the latest version:
- Pulls latest code from repository
- Updates Docker images
- Applies database migrations
- Restarts services

### Service Management Commands

#### `make up`
Starts all services defined in docker-compose:
- Home Assistant
- Frigate
- Qwen3-Omni
- Whisper STT
- Piper TTS
- Monitoring stack

#### `make down`
Gracefully stops all services:
- Sends termination signals
- Waits for clean shutdown
- Preserves data volumes

#### `make restart`
Restarts all services:
- Stops all services
- Starts all services
- Useful for applying configuration changes

### Development Commands

#### `make build`
Builds all custom Docker images:
- Omni module image
- Custom Frigate configuration
- Home Assistant custom components

#### `make test`
Runs all test suites:
- Unit tests for core components
- Integration tests for service interactions
- Performance tests for AI models

### Maintenance Commands

#### `make backup`
Creates complete system backup:
- Database dumps
- Configuration files
- Model files (if space allows)
- Docker volume snapshots

#### `make restore`
Restores system from backup:
- Stops all services
- Restores data from backup file
- Starts services
- Validates restoration

### Monitoring Commands

#### `make logs`
Displays logs from all services:
- Combined log output
- Color-coded by service
- Timestamped entries

#### `make health`
Checks health of all services:
- Service status (running/stopped)
- Health check results
- Resource utilization
- Error counts

### AI Model Commands

#### `make download-models`
Downloads required AI models:
- Qwen3-Omni model
- Whisper STT model
- Piper TTS voices
- Computer vision models

#### `make quantize-models`
Quantizes models for efficiency:
- Converts models to lower precision
- Reduces memory requirements
- Maintains acceptable accuracy

## 🛠️ Customization

### Environment Variables
Create a `.env` file to customize behavior:
```bash
# GPU configuration
GPU_DEVICE=0
GPU_MEMORY=24G

# Model paths
MODEL_QWEN3=/path/to/qwen3-model
MODEL_WHISPER=/path/to/whisper-model

# Service ports
PORT_HOME_ASSISTANT=8123
PORT_FRIGATE=5000
```

### Service Selection
Start only specific services:
```bash
# Start only core AI services
make up-core

# Start only monitoring services
make up-monitoring

# Start only computer vision services
make up-vision
```

## 🐛 Troubleshooting

### Common Issues

#### Docker Permission Errors
```bash
# Add user to docker group
sudo usermod -aG docker $USER

# Restart Docker service
sudo systemctl restart docker
```

#### GPU Not Detected
```bash
# Check NVIDIA drivers
nvidia-smi

# Install NVIDIA Container Toolkit
make install-nvidia
```

#### Services Not Starting
```bash
# Check logs for specific service
make logs-service SERVICE=home-assistant

# Rebuild specific service
make build-service SERVICE=home-assistant
```

#### Insufficient Disk Space
```bash
# Clean unused Docker resources
make docker-clean

# Remove old backups
make clean-backups
```

## 📈 Performance Tips

### Resource Optimization
```bash
# Use GPU acceleration
make up-gpu

# Limit resource usage
make up-light

# Enable experimental features
make up-experimental
```

### Development Workflow
```bash
# Development mode with hot reloading
make dev

# Test-driven development
make tdd

# Continuous integration
make ci
```

## 🔒 Security Considerations

### Secure Operations
```bash
# Run security audit
make audit

# Update to secure versions
make secure-update

# Check for vulnerabilities
make scan-vulnerabilities
```

### Backup Security
```bash
# Encrypt backups
make backup-encrypted

# Secure backup storage
make backup-secure
```
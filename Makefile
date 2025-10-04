# Vita Smart Home System Makefile
# Documentation: docs/makefile_guide.md

# Default environment variables
GPU_DEVICE ?= 0
PORT_HOME_ASSISTANT ?= 8123
PORT_FRIGATE ?= 5000
PORT_OMNI ?= 11437

# Default target
.PHONY: help
help:
	@echo "Vita Smart Home System - Makefile"
	@echo "=================================="
	@echo "Available commands:"
	@echo "  setup          - Complete initial setup"
	@echo "  install        - Install system dependencies"
	@echo "  up             - Start all services"
	@echo "  down           - Stop all services"
	@echo "  restart        - Restart all services"
	@echo "  status         - Check system status"
	@echo "  logs           - View all logs"
	@echo "  build          - Build all containers"
	@echo "  test           - Run all tests"
	@echo "  backup         - Backup system data"
	@echo "  update         - Update to latest version"
	@echo "  clean          - Clean installation (removes all data)"
	@echo ""
	@echo "For more details, see docs/makefile_guide.md"

# Setup and Installation
.PHONY: setup
setup:
	@echo "Setting up Vita Smart Home System..."
	# Create required directories
	mkdir -p models inputs
	# Copy example environment file
	cp .env.example .env 2>/dev/null || echo "No .env.example file found"
	@echo "Setup complete. Please review the .env file and adjust settings as needed."

.PHONY: install
install:
	@echo "Installing system dependencies..."
	# Check if Docker is installed
	@if ! command -v docker &> /dev/null; then \
		echo "Docker not found. Please install Docker first."; \
		exit 1; \
	fi
	# Check if Docker Compose is installed
	@if ! command -v docker-compose &> /dev/null; then \
		echo "Docker Compose not found. Please install Docker Compose first."; \
		exit 1; \
	fi
	@echo "System dependencies check passed."

# Service Management
.PHONY: up
up:
	@echo "Starting all services..."
	docker-compose up -d

.PHONY: down
down:
	@echo "Stopping all services..."
	docker-compose down

.PHONY: restart
restart: down up

.PHONY: status
status:
	@echo "Checking system status..."
	docker-compose ps

.PHONY: logs
logs:
	@echo "Viewing all logs..."
	docker-compose logs -f

# Development Commands
.PHONY: build
build:
	@echo "Building all containers..."
	docker-compose build

.PHONY: test
test:
	@echo "Running tests..."
	@echo "Note: Implement specific test commands based on your testing framework"

# Maintenance Commands
.PHONY: backup
backup:
	@echo "Creating system backup..."
	# Create backup directory if it doesn't exist
	mkdir -p backups
	# Create timestamp for backup file
	BACKUP_FILE="backups/vita-backup-$$(date +%Y%m%d-%H%M%S).tar.gz"
	# Backup important directories and files
	tar -czf "$$BACKUP_FILE" .env compose/ docs/ 2>/dev/null || echo "Some files may not be available for backup"
	@echo "Backup created: $$BACKUP_FILE"

.PHONY: update
update:
	@echo "Updating to latest version..."
	git pull origin main
	docker-compose pull
	@echo "Update complete. Restart services to apply changes."

.PHONY: clean
clean:
	@echo "Cleaning installation..."
	@echo "WARNING: This will remove all data volumes!"
	@read -p "Are you sure you want to continue? (y/N): " confirm && [ "$$confirm" = "y" ] || exit 1
	docker-compose down -v
	rm -rf models/* inputs/* 2>/dev/null || true
	@echo "Clean installation complete."
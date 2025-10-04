# 🤝 Contributing Guide

Thank you for wanting to contribute to **Smart Home AI Orchestrator**!

---

## 🚀 Getting Started
1. Fork the repository
2. Create a branch for your task:
   ```bash
   git checkout -b feature/my-feature
   ```
3. Make changes and test:
   ```bash
   make build && make run
   make healthcheck
   ```
4. Create a Pull Request using the [template](.github/pull_request_template.md)

---

## 📂 Project Structure
- `compose/` — docker-compose files
- `make/` — Makefile and scripts
- `omni/` — multimodal agent
- `node-red/` — ready flows
- `docs/` — documentation
- `.env.example` — environment variables

---

## 🧪 Testing
- Use `make test-image` and `make test-audio` to test Omni
- Check VRAM: `make vram`
- Monitor healthcheck: `make healthcheck`

---

## 📜 Rules
- Format code in a consistent style (Python: PEP8)
- Write documentation in Markdown
- All new features should be accompanied by README or docs/ updates
- Before PR, make sure the stack starts without errors

---

## 🙌 Acknowledgements
Every contribution is valuable. Even fixing a typo in the documentation helps the project!
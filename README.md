# 🧠 ai-llmacpp

> A lightweight launcher for running `llama.cpp` models locally with enhanced usability and flexible shell scripts 
> for macOS, Linux, and Windows.

![Shell](https://img.shields.io/badge/shell-Bash-blue)
![Platform](https://img.shields.io/badge/platform-macOS%20|%20Linux%20|%20Windows-green)
![License](https://img.shields.io/badge/license-MIT-lightgrey)

---

## 🚀 Features

- ✅ Quick CLI launcher for `llama.cpp` models
- 🔍 Model prefix matching + interactive selection
- 🖥️  macOS/Linux support with Metal or multi-core CPU
- 🪟 Windows support with optional DirectML acceleration
- 📁 Ignores large model files while keeping folder structure
- 🧼 Clean and portable — no Python or extra deps required

---

## 📁 Folder Structure

```
.
├── models/
│   ├── kingabzpro/ (example)
│   ├── mistral/    (example)
│   ├── phi3/       (example)
├── run-llama-universal.sh     # macOS + Linux runner
├── run-llama-macos.sh         # macOS specific runner
├── run-llama-linux.sh         # Linux specific runner
├── run-llama-windows.bat      # Windows runner (PowerShell inside)
├── setup_llama_mac.sh         # macOS setup script (Metal support)
├── setup_llama_windows_advanced.bat  # Windows setup (DirectML or CPU)
```

---

## 🛠️ Setup

### macOS

```bash
bash setup_llama_mac.sh
```

### Linux

```bash
# Manually build llama.cpp or use the universal script
make -j LLAMA_OPENBLAS=1
```

### Windows

Run from Git Bash or CMD:

```bat
setup_llama_windows_advanced.bat
```

---

## 🧠 Run it

Run from your terminal:

```bash
./run-llama-linux-mac.sh mistral "Explain RAG in simple terms"
```

If multiple models match, you'll be prompted to pick one.

---

## 📦 Dependencies

- `llama.cpp` compiled locally
- macOS: Metal support enabled (`LLAMA_METAL=1`)
- Linux: OpenBLAS (`LLAMA_OPENBLAS=1`)
- Windows: Visual Studio + optional DirectML

---

## 📄 License

MIT — free to use, modify, and share.

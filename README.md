# 🧠 ai-llmacpp

> A lightweight, local-first launcher for running `llama.cpp` models using flexible shell scripts across macOS, Linux, and Windows.

![Shell](https://img.shields.io/badge/shell-Bash-blue)
![Platform](https://img.shields.io/badge/platform-macOS%20|%20Linux%20|%20Windows-green)
![License](https://img.shields.io/badge/license-MIT-lightgrey)

---

## 🚀 Features

- ✅ Quick CLI launcher for `llama.cpp` models
- 🔍 Model prefix matching + interactive selection
- 🖥️ Runs on macOS (Metal), Linux (OpenBLAS), and Windows (CPU/DirectML)
- 📦 Smart model downloader with skip-if-exists support
- 📁 Clean structure: models are gitignored, folders preserved
- 🧼 No Python required — just shell scripts and compiled C++

---

## 📁 Folder Structure

```
.
├── models/                             # Place your GGUF models here
├── download_models.sh                  # (Deprecated) hardcoded Linux/macOS downloader
├── download_models_windows.bat         # (Deprecated) hardcoded Windows downloader
├── download_models_file.sh             # New file-based Linux/macOS model downloader
├── download_models_file_windows.bat    # New file-based Windows model downloader
├── model_urls.txt                      # All the model urls 
├── run_llama_linux_mac.sh              # Combined launcher for Linux/macOS
├── run_llama_linux.sh                  # Linux-only launcher
├── run_llama_macos.sh                  # macOS-only launcher
├── run_llama_windows.bat               # Windows launcher
├── setup_llama_linux.sh                # Linux setup script
├── setup_llama_mac.sh                  # macOS setup script
├── setup_llama_windows.bat             # Windows basic setup
├── setup_llama_windows_advanced.bat    # Windows DirectML/advanced setup
└── README.md
```

---

## 🛠️ Setup

### Step 1: Compile `llama.cpp`

#### macOS

```bash
bash setup_llama_mac.sh
```

#### Linux

```bash
bash setup_llama_linux.sh
```

#### Windows

Run either:

```bat
setup_llama_windows.bat
```

or (with DirectML support):

```bat
setup_llama_windows_advanced.bat
```

---

### Step 2: Download models (Recommended)

Use the new file-based scripts:

#### Linux / macOS

```bash
bash download_models_file.sh
```

#### Windows

```bat
download_models_file_windows.bat
```

These scripts:
- Read from `model_urls.txt` (one model path and URL per line)
- Download recommended models for common setups
- Skip downloads if the `.gguf` files already exist
- Place files in the proper `models/` subfolders

You can still use the older hardcoded scripts (`download_models.sh`, `download_models_windows.bat`) if needed.

These scripts:
- Download recommended models for common setups
- Skip downloads if the `.gguf` files already exist
- Place files in the proper `models/` subfolders

---

## 🧠 Run it

### For Linux or macOS

```bash
./run_llama_linux_mac.sh mistral "What is Retrieval-Augmented Generation?"
```

### For Windows

```bat
run_llama_windows.bat mistral "What is Llama.cpp?"
```


You can pass:
- A model prefix (e.g. `mistral`, `phi`, `llama`)
- A prompt to evaluate

If multiple models match, it will prompt you to pick one.

---

## 📦 Dependencies

- `llama.cpp` (built locally)
- macOS: Metal (`LLAMA_METAL=1`)
- Linux: OpenBLAS (`LLAMA_OPENBLAS=1`)
- Windows: Visual Studio, MSVC tools, (optional) DirectML

---

## 📄 License

MIT — free to use, modify, and share.

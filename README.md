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

### Step 1: Clone this repo

1. Pick a directory to store this repo

If you're new, just create a new directory in a place that you can easily access.

In my case I store all my repos in my root folder:

```bash
cd ~		    # root directory
mkdir code      # this is where you will store all your GitHub repos
```

2. Now just clone this repo to your root GitHub repo storage

```bash
# This is where all my GitHub repos live
cd ~/code   

# Get this repo (it will create the repo directory for you)
git clone https://github.com/rabb1tl0ka/ai-llmacpp.git
```

### Step 2: Setup `llama.cpp`

Make sure that you're not running the `setup_llama` scripts inside this repo.

This is the reason why the first line below is to go to the root directory where you store all your GitHub projects.


```bash
# Go to where all your GitHub repos are
cd ~/code

# Then just run the setup llama script for your OS of choice.
# Here I'm using Linux
bash ./ai-llmacpp/setup_llama_linux.sh
```

---

### Step 3: Download models (Recommended)

If you want to get started with some recommended models that just work out-of-the-box, then do this:

```bash
# Go to where you cloned this repo
cd ~/code/ai-llmacpp

# Execute the download models script for Linux and macOS
bash download_models_file.sh

# Or Windows
download_models_file_windows.bat
```

These scripts:
- Read from `model_urls.txt` (you can add more models if you want to but this already comes with some popular choices!)
- Skip downloads if the `.gguf` files already exist
- Place files in the proper `models/` subfolders (so you don't have to worry about it.)

---

## 🧠 Run it (easy!)

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

@echo off
REM download_models_windows.bat — Download GGUF models based on model_urls.txt

setlocal enabledelayedexpansion

set "MODEL_LIST_FILE=model_urls.txt"

if not exist "%MODEL_LIST_FILE%" (
    echo ❌ Error: model list file not found: %MODEL_LIST_FILE%
    exit /b 1
)

echo 📥 Downloading GGUF models...

for /f "usebackq tokens=1,2 delims=," %%A in ("%MODEL_LIST_FILE%") do (
    set "MODEL_PATH=%%A"
    set "MODEL_URL=%%B"

    if exist "!MODEL_PATH!" (
        echo ✅ Already exists: !MODEL_PATH!
    ) else (
        echo 🔽 Downloading: !MODEL_PATH!
        powershell -Command "New-Item -ItemType Directory -Force -Path "$(Split-Path -Path '!MODEL_PATH!')""
        powershell -Command "Invoke-WebRequest -Uri '!MODEL_URL!' -OutFile '!MODEL_PATH!'"
    )
)

echo ✅ All downloads completed (or skipped).
pause

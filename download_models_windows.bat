@echo off
REM Download GGUF models (Windows version)
REM Skips files if already downloaded

echo 📥 Downloading GGUF models...

REM Mistral 7B Q4_K_M
IF EXIST models\mistral\mistral-7b-instruct-v0.2.Q4_K_M.gguf (
    echo ✅ Already exists: mistral-7b-instruct-v0.2.Q4_K_M.gguf
) ELSE (
    echo 🔽 Downloading: mistral-7b-instruct-v0.2.Q4_K_M.gguf
    powershell -Command "New-Item -ItemType Directory -Force -Path models\mistral"
    powershell -Command "Invoke-WebRequest -Uri https://huggingface.co/TheBloke/Mistral-7B-Instruct-v0.2-GGUF/resolve/main/mistral-7b-instruct-v0.2.Q4_K_M.gguf -OutFile models\mistral\mistral-7b-instruct-v0.2.Q4_K_M.gguf"
)

REM Mistral 7B Q4_0
IF EXIST models\mistral\mistral-7b-instruct-v0.2.Q4_0.gguf (
    echo ✅ Already exists: mistral-7b-instruct-v0.2.Q4_0.gguf
) ELSE (
    echo 🔽 Downloading: mistral-7b-instruct-v0.2.Q4_0.gguf
    powershell -Command "Invoke-WebRequest -Uri https://huggingface.co/TheBloke/Mistral-7B-Instruct-v0.2-GGUF/resolve/main/mistral-7b-instruct-v0.2.Q4_0.gguf -OutFile models\mistral\mistral-7b-instruct-v0.2.Q4_0.gguf"
)

REM Phi-2 Q4_K_M
IF EXIST models\phi3\phi-2.Q4_K_M.gguf (
    echo ✅ Already exists: phi-2.Q4_K_M.gguf
) ELSE (
    echo 🔽 Downloading: phi-2.Q4_K_M.gguf
    powershell -Command "New-Item -ItemType Directory -Force -Path models\phi3"
    powershell -Command "Invoke-WebRequest -Uri https://huggingface.co/TheBloke/Phi-2-GGUF/resolve/main/phi-2.Q4_K_M.gguf -OutFile models\phi3\phi-2.Q4_K_M.gguf"
)

REM LLaMA 13B Q4_0
IF EXIST models\llama\llama-2-13b-chat.Q4_0.gguf (
    echo ✅ Already exists: llama-2-13b-chat.Q4_0.gguf
) ELSE (
    echo 🔽 Downloading: llama-2-13b-chat.Q4_0.gguf
    powershell -Command "New-Item -ItemType Directory -Force -Path models\llama"
    powershell -Command "Invoke-WebRequest -Uri https://huggingface.co/TheBloke/Llama-2-13B-chat-GGUF/resolve/main/llama-2-13b-chat.Q4_0.gguf -OutFile models\llama\llama-2-13b-chat.Q4_0.gguf"
)

echo ✅ All downloads completed (or skipped).
pause

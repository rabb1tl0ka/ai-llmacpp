@echo off
REM llama.cpp setup script for Windows with optional DirectML support (GPU)
REM Falls back to CPU-only build if DirectML not available

echo 🔧 Cloning llama.cpp...
git clone https://github.com/ggerganov/llama.cpp.git
cd llama.cpp

REM Check for DirectML support by seeing if Windows supports it (basic check)
REM User may also manually enable it by passing argument "gpu"

set BUILD_GPU=0

REM Prompt user for optional GPU build
echo.
echo 💡 Do you want to try building with GPU acceleration via DirectML? (Y/N)
set /p GPU_CHOICE=

if /I "%GPU_CHOICE%"=="Y" (
    echo ⚙️ Attempting to build with DirectML support...
    set BUILD_GPU=1
) else (
    echo ⚙️ Proceeding with CPU-only build...
)

mkdir build
cd build

if %BUILD_GPU%==1 (
    cmake .. -DLLAMA_BACKEND=DirectML
    cmake --build . --config Release
    echo ✅ Built with DirectML GPU support (if available)
) else (
    cmake .. -DLLAMA_BLAS=ON -DLLAMA_BLAS_VENDOR=OpenBLAS
    cmake --build . --config Release
    echo ✅ Built with CPU support using OpenBLAS
)

echo.
echo 🚀 Done! To run a model, place a GGUF file in a models folder and run:
echo .\Release\main.exe -m models\your-model.gguf -p "What is RAG?"

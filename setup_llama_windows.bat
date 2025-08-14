@echo off
REM llama.cpp setup instructions for Windows (CPU-only)

echo 🔧 Cloning llama.cpp...
git clone https://github.com/ggerganov/llama.cpp.git
cd llama.cpp

echo ⚙️ Building llama.cpp with CMake...
REM Prerequisites: Visual Studio with CMake tools installed
mkdir build
cd build
cmake .. -DLLAMA_BLAS=ON -DLLAMA_BLAS_VENDOR=OpenBLAS
cmake --build . --config Release

echo ✅ llama.cpp built successfully!
echo Place a GGUF model in a models directory and run:
echo .\Release\main.exe -m models\your-model.gguf -p "What is RAG?"

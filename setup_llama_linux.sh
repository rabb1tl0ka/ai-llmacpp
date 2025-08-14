#!/bin/bash
# setup_llama_linux.sh - Install dependencies and build llama.cpp with OpenBLAS

set -e

echo "🔧 Setting up llama.cpp for Linux..."

# Install dependencies
echo "📦 Installing required packages..."
sudo apt update && sudo apt install -y build-essential cmake git libopenblas-dev

# Clone llama.cpp if not already present
if [ ! -d "llama.cpp" ]; then
  echo "📁 Cloning llama.cpp..."
  git clone https://github.com/ggerganov/llama.cpp.git
else
  echo "📁 llama.cpp already exists, pulling latest changes..."
  cd llama.cpp && git pull && cd ..
fi

# Build with OpenBLAS
echo "🔨 Building llama.cpp with OpenBLAS..."
cd llama.cpp
make clean
make -j$(nproc) LLAMA_OPENBLAS=1

echo "✅ llama.cpp built successfully with OpenBLAS support."

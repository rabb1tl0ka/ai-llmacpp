#!/bin/bash

# llama.cpp setup script for macOS with Metal support (Apple Silicon)

echo "🔧 Cloning llama.cpp..."
git clone https://github.com/ggerganov/llama.cpp.git
cd llama.cpp

echo "⚙️ Building with Metal support..."
make LLAMA_METAL=1

echo "✅ llama.cpp built successfully with Metal support!"
echo "To run a model, place a GGUF model in the models folder and use:"
echo "./main -m models/your-model.gguf -p \"What is RAG?\""

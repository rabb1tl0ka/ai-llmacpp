#!/bin/bash
# Cross-platform GGUF model downloader (Linux/macOS)
# Skips existing files

set -e

echo "📥 Downloading GGUF models..."

download_if_missing() {
  MODEL_PATH="$1"
  URL="$2"

  if [ -f "$MODEL_PATH" ]; then
    echo "✅ Already exists: $MODEL_PATH"
  else
    echo "🔽 Downloading: $MODEL_PATH"
    mkdir -p "$(dirname "$MODEL_PATH")"
    curl -L -o "$MODEL_PATH" "$URL"
  fi
}

# Mistral 7B Q4_K_M
download_if_missing "models/mistral/mistral-7b-instruct-v0.2.Q4_K_M.gguf" \
  "https://huggingface.co/TheBloke/Mistral-7B-Instruct-v0.2-GGUF/resolve/main/mistral-7b-instruct-v0.2.Q4_K_M.gguf"

# Mistral 7B Q4_0
download_if_missing "models/mistral/mistral-7b-instruct-v0.2.Q4_0.gguf" \
  "https://huggingface.co/TheBloke/Mistral-7B-Instruct-v0.2-GGUF/resolve/main/mistral-7b-instruct-v0.2.Q4_0.gguf"

# Phi-2 Q4_K_M
download_if_missing "models/phi3/phi-2.Q4_K_M.gguf" \
  "https://huggingface.co/TheBloke/Phi-2-GGUF/resolve/main/phi-2.Q4_K_M.gguf"

# LLaMA 2 13B Q4_0
download_if_missing "models/llama/llama-2-13b-chat.Q4_0.gguf" \
  "https://huggingface.co/TheBloke/Llama-2-13B-chat-GGUF/resolve/main/llama-2-13b-chat.Q4_0.gguf"

echo "✅ All downloads completed (or skipped)."

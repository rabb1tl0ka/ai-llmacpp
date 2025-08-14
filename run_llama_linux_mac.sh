#!/bin/bash
# Cross-platform (macOS + Linux) LLM launcher for llama.cpp models
echo "Cross-platform (macOS + Linux) LLM launcher for llama.cpp models 🚀"

set -euo pipefail

# === Config ===
MODEL_DIR="$HOME/code/ai-llmacpp/models"
LLAMA_BIN="$HOME/code/llama.cpp/build/bin/llama-cli"
CTX=4096

# Platform-specific CPU thread detection
if command -v nproc &> /dev/null; then
  THREADS="$(nproc)"
elif command -v sysctl &> /dev/null; then
  THREADS="$(sysctl -n hw.ncpu)"
else
  THREADS=4  # fallback
fi

usage() {
  echo "Usage: $(basename "$0") <model-name or prefix> [prompt]"
  echo
  echo "Examples:"
  echo "  $(basename "$0") mistral 'List 5 Linux or Mac tips'"
  echo "  $(basename "$0") phi-3-mini 'Explain transformers'"
  echo
  echo "Available models:"
  find "$MODEL_DIR" -type f -name "*.gguf" | sed "s|$MODEL_DIR/|  |" | sort
}

if [ $# -lt 1 ]; then
  usage
  exit 1
fi

MODEL_KEY="$1"; shift || true
PROMPT="${*:-"You are a helpful assistant. Say hello."}"

# Gather matching models
IFS=$'\n' read -r -d '' -a MATCHES < <(find "$MODEL_DIR" -type f -name "${MODEL_KEY}*.gguf" -print0 | sort -z)

if [ "${#MATCHES[@]}" -eq 0 ]; then
  echo "No models found for key: ${MODEL_KEY}"
  echo
  usage
  exit 1
fi

if [ "${#MATCHES[@]}" -gt 1 ]; then
  echo "Multiple models matched '${MODEL_KEY}'. Pick one:"
  select CHOICE in "${MATCHES[@]}"; do
    if [[ -n "${CHOICE:-}" ]]; then
      MODEL_PATH="$CHOICE"
      break
    else
      echo "Invalid selection."
    fi
  done
else
  MODEL_PATH="${MATCHES[0]}"
fi

# Run the model
echo "→ Using model: $MODEL_PATH"
echo "→ Prompt: $PROMPT"
"$LLAMA_BIN" \
  -m "$MODEL_PATH" \
  --threads "$THREADS" \
  --ctx-size "$CTX" \
  -i \
  -p "$PROMPT"

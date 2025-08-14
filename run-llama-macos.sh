#!/bin/bash
# macOS-compatible LLM launcher for llama.cpp models
echo "Simple macOS only LLM launcher for llama.cpp models with interactive picker 🚀"

set -euo pipefail

MODEL_DIR="$HOME/code/ai-llmacpp/models"
LLAMA_BIN="$HOME/code/llama.cpp/build/bin/llama-cli"
THREADS="$(sysctl -n hw.ncpu)"
CTX=4096

usage() {
  echo "Usage: $(basename "$0") <model-name or prefix> [prompt]"
  echo
  echo "Examples:"
  echo "  $(basename "$0") mistral 'List 5 Mac tips'"
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

MATCHES=($(find "$MODEL_DIR" -type f -name "${MODEL_KEY}*.gguf" | sort))

if [ ${#MATCHES[@]} -eq 0 ]; then
  echo "No models found for key: ${MODEL_KEY}"
  echo
  usage
  exit 1
fi

if [ ${#MATCHES[@]} -gt 1 ]; then
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

echo "→ Using model: $MODEL_PATH"
echo "→ Prompt: $PROMPT"
"$LLAMA_BIN" \
  -m "$MODEL_PATH" \
  --threads "$THREADS" \
  --ctx-size "$CTX" \
  -i \
  -p "$PROMPT"

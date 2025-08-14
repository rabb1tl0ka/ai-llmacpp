#!/usr/bin/env bash
# Simple LLM launcher for llama.cpp models with interactive picker
echo "Simple linux LLM launcher for llama.cpp models with interactive picker 🚀"

set -euo pipefail

# Folder where all your models are stored
MODEL_DIR="$HOME/code/ai-llmacpp/models"

# llama.cpp binary path
LLAMA_BIN="$HOME/code/llama.cpp/build/bin/llama-cli"

# Default inference settings (tweak as you like)
THREADS="$(nproc)"
CTX=4096

usage() {
  echo "Usage: $(basename "$0") <model-name or prefix> [prompt]"
  echo
  echo "Examples:"
  echo "  $(basename "$0") mistral 'List 5 Linux tips'"
  echo "  $(basename "$0") phi-3-mini-4k-instruct.Q4_K_M 'Explain transformers'"
  echo
  echo "Available models:"
  find "$MODEL_DIR" -type f -name "*.gguf" -printf "  %P\n" | sort
}

# Need at least a model key
if [ $# -lt 1 ]; then
  usage
  exit 1
fi

MODEL_KEY="$1"; shift || true
PROMPT="${*:-"You are a helpful assistant. Say hello."}"

# Find matching GGUF files
mapfile -t MATCHES < <(find "$MODEL_DIR" -type f -name "${MODEL_KEY}*.gguf" | sort)

if [ "${#MATCHES[@]}" -eq 0 ]; then
  echo "No models found for key: ${MODEL_KEY}"
  echo
  usage
  exit 1
fi

if [ "${#MATCHES[@]}" -gt 1 ]; then
  echo "Multiple models matched '${MODEL_KEY}'. Pick one:"
  PS3="Select model [1-${#MATCHES[@]}]: "
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

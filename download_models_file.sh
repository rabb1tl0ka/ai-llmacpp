#!/bin/bash
# download_models_files.sh — download GGUF models based on list file
echo "📥 download GGUF models based on list file"

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

# Read from model_urls.txt
MODEL_LIST_FILE="model_urls.txt"

if [ ! -f "$MODEL_LIST_FILE" ]; then
  echo "❌ Error: model list file not found: $MODEL_LIST_FILE"
  exit 1
fi

while IFS=',' read -r model_path url; do
  download_if_missing "$model_path" "$url"
done < "$MODEL_LIST_FILE"

echo "✅ All downloads completed (or skipped)."

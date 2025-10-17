#!/usr/bin/env bash
set -e

echo "🚀 Starting ComfyUI-RunPod-WanAnimate..."

/opt/download_models.sh || true

python main.py --listen 0.0.0.0 --port 8188

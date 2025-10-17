#!/bin/bash
set -e

echo "🌀 RunPod Startup - WanAnimate Template"
cd /workspace

# Clone repo
if [ ! -d "/workspace/ComfyUI-RunPod-WanAnimate" ]; then
    echo "📦 Cloning ComfyUI repo..."
    git clone https://github.com/HaiMinh2410/ComfyUI-RunPod-WanAnimate.git
fi

cd ComfyUI-RunPod-WanAnimate

# Install dependencies
echo "⚙️ Installing Python dependencies..."
pip install --upgrade pip
pip install -r requirements.txt

# Prepare temp model directory
export MODEL_DIR="/workspace/tmp_models"

# Download models (into ephemeral storage)
echo "📥 Downloading models to ${MODEL_DIR} ..."
bash download_models.sh

# Start ComfyUI
echo "🚀 Starting ComfyUI on port 8188..."
python ComfyUI/main.py --listen 0.0.0.0 --port 8188

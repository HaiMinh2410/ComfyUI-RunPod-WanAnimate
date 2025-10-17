#!/bin/bash
echo "🚀 [RunPod] Starting ComfyUI-RunPod-WanAnimate setup..."

apt-get update && apt-get install -y git python3 python3-pip ffmpeg libgl1 libglib2.0-0

REPO_URL="https://huggingface.co/highminh/ComfyUI-RunPod-WanAnimate"
APP_DIR="/workspace/app"

if [ ! -d "$APP_DIR" ]; then
    echo "📦 Cloning Hugging Face repo..."
    git clone $REPO_URL $APP_DIR
fi

cd $APP_DIR
pip install --upgrade pip
pip install -r requirements.txt

chmod +x startup.sh Animate.txt
bash Animate.txt || echo "⚠️ Animate.txt finished with warning"

echo "📂 Starting file manager (HTTP 3000)..."
python3 -m http.server 3000 --directory $APP_DIR/ComfyUI/output &

echo "🎨 Starting ComfyUI (HTTP 8188)..."
cd ComfyUI
python3 main.py --listen 0.0.0.0 --port 8188

#!/bin/bash
set -e

echo "🌀 [RunPod Startup] Initializing WanAnimate ComfyUI Template..."
cd /workspace

# ==========================================================
# 1️⃣ Clone or update your ComfyUI repo
# ==========================================================
if [ ! -d "/workspace/ComfyUI-RunPod-WanAnimate" ]; then
    echo "📦 Cloning repo from GitHub..."
    git clone https://github.com/HaiMinh2410/ComfyUI-RunPod-WanAnimate.git
else
    echo "🔄 Pulling latest changes from GitHub..."
    cd /workspace/ComfyUI-RunPod-WanAnimate && git pull || true
    cd ..
fi

cd /workspace/ComfyUI-RunPod-WanAnimate

# ==========================================================
# 2️⃣ Install Python dependencies
# ==========================================================
echo "⚙️ Installing Python dependencies..."
pip install --upgrade pip
pip install --no-cache-dir -r requirements.txt

# ==========================================================
# 3️⃣ Prepare temp model folder
# ==========================================================
export MODEL_DIR="/workspace/tmp_models"
echo "🧱 Creating temp model folder at ${MODEL_DIR}"
mkdir -p ${MODEL_DIR}

# ==========================================================
# 4️⃣ Download models (ephemeral)
# ==========================================================
if [ -f "./download_models.txt" ]; then
    echo "📥 Downloading WanAnimate models..."
    chmod +x ./download_models.txt
    bash ./download_models.txt || echo "⚠️ Model download script exited with warning."
else
    echo "❌ No download_models.txt found in repo — skipping model download."
fi

# ==========================================================
# 5️⃣ Replace RunPod's default ComfyUI with your version
# ==========================================================
echo "🔁 Replacing RunPod's default ComfyUI with your version..."
if [ -d "/workspace/runpod-slim/ComfyUI" ]; then
    rm -rf /workspace/runpod-slim/ComfyUI
fi
cp -r ./ComfyUI /workspace/runpod-slim/

# ==========================================================
# 6️⃣ Link your temporary model folder to ComfyUI models path
# ==========================================================
COMFY_PATH="/workspace/runpod-slim/ComfyUI/models"
echo "🔗 Linking ${MODEL_DIR} -> ${COMFY_PATH}"
rm -rf "${COMFY_PATH}" || true
ln -s ${MODEL_DIR} ${COMFY_PATH}

# ==========================================================
# 7️⃣ Start background services (Jupyter & FileBrowser)
# ==========================================================
echo "🧠 Starting JupyterLab (port 8888)..."
nohup jupyter lab --ip=0.0.0.0 --port=8888 \
  --no-browser --NotebookApp.token='' --NotebookApp.password='' \
  > /workspace/jupyter.log 2>&1 &

echo "📂 Starting FileBrowser (port 8080)..."
nohup filebrowser -r /workspace -p 8080 > /workspace/filebrowser.log 2>&1 &

# ==========================================================
# 8️⃣ Start ComfyUI (foreground)
# ==========================================================
echo "🚀 Starting your ComfyUI on port 8188..."
cd /workspace/runpod-slim/ComfyUI
python main.py --listen 0.0.0.0 --port 8188

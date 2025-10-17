# ====== BASE IMAGE ======
FROM nvidia/cuda:12.1.1-cudnn8-runtime-ubuntu22.04

# ====== SYSTEM DEPENDENCIES ======
RUN apt-get update && apt-get install -y \
    python3 python3-pip git wget curl ffmpeg libgl1 libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# ====== SETUP ENVIRONMENT ======
ENV PYTHONUNBUFFERED=1
WORKDIR /workspace

# ====== COPY SOURCE ======
COPY requirements.txt ./
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

COPY . .

# ====== DOWNLOAD MODELS ======
RUN chmod +x download_models.sh
RUN ./download_models.sh || echo "Model download skipped"

# ====== EXPOSE PORTS ======
EXPOSE 8188

# ====== ENTRY POINT ======
CMD ["python3", "ComfyUI/main.py", "--listen", "0.0.0.0", "--port", "8188"]

# -------- 1. Base image --------
FROM python:3.10-slim

# -------- 2. Working directory --------
WORKDIR /workspace

# -------- 3. Install system dependencies --------
RUN apt-get update && apt-get install -y \
    git wget curl ffmpeg libsm6 libxext6 unzip && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# -------- 4. Clone Hugging Face repo --------
# ⚠️ Thay <username> bằng username Hugging Face của bạn
RUN git lfs install && \
    git clone https://huggingface.co/highminh/ComfyUI-RunPod-WanAnimate app

# -------- 5. Install Python dependencies --------
WORKDIR /workspace/app
RUN pip install --upgrade pip && \
    if [ -f "requirements.txt" ]; then pip install -r requirements.txt; fi && \
    pip install -e ./ComfyUI

# -------- 6. Set execute permission --------
RUN chmod +x startup.sh Animate.txt

# -------- 7. Default command --------
CMD ["bash", "startup.sh"]

#!/usr/bin/env bash
set -e

echo "📥 Checking WanAnimate models..."

if [ -d "${MODEL_DIR}/diffusion_models" ]; then
  echo "✅ Models already exist, skipping download."
  exit 0
fi

echo "📦 Downloading WanAnimate models into ${MODEL_DIR} ..."
cd ${MODEL_DIR}

mkdir -p diffusion_models && cd diffusion_models
wget -nc https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_animate_14B_bf16.safetensors
cd ..

mkdir -p unet && cd unet
wget -nc https://huggingface.co/QuantStack/Wan2.2-Animate-14B-GGUF/resolve/main/Wan2.2-Animate-14B-Q4_K_M.gguf
cd ..

mkdir -p vae && cd vae
wget -nc https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/Wan2_1_VAE_fp32.safetensors
cd ..

mkdir -p text_encoders && cd text_encoders
wget -nc https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/umt5-xxl-enc-fp8_e4m3fn.safetensors
wget -nc https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/umt5-xxl-enc-bf16.safetensors
cd ..

mkdir -p clip_vision && cd clip_vision
wget -nc https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/clip_vision/clip_vision_h.safetensors
cd ..

mkdir -p Loras && cd Loras
wget -nc https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/LoRAs/Wan22_relight/WanAnimate_relight_lora_fp16.safetensors
wget -nc https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/Lightx2v/lightx2v_I2V_14B_480p_cfg_step_distill_rank256_bf16.safetensors
cd ..

mkdir -p detection && cd detection
wget -nc https://huggingface.co/JunkyByte/easy_ViTPose/resolve/main/onnx/wholebody/vitpose-l-wholebody.onnx
wget -nc https://huggingface.co/Wan-AI/Wan2.2-Animate-14B/resolve/main/process_checkpoint/det/yolov10m.onnx
cd ..

mkdir -p sams && cd sams
wget -nc https://huggingface.co/VeryAladeen/Sec-4B/resolve/main/SeC-4B-fp16.safetensors
cd ..

echo "✅ All WanAnimate models downloaded successfully!"

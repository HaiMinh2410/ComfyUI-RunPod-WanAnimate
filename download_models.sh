#!/usr/bin/env bash
set -e

MODEL_DIR="/workspace/tmp_models"
echo "📥 Downloading WanAnimate models into $MODEL_DIR ..."

mkdir -p ${MODEL_DIR}/diffusion_models \
         ${MODEL_DIR}/unet \
         ${MODEL_DIR}/vae \
         ${MODEL_DIR}/text_encoders \
         ${MODEL_DIR}/clip_vision \
         ${MODEL_DIR}/Loras \
         ${MODEL_DIR}/detection \
         ${MODEL_DIR}/sams

cd ${MODEL_DIR}/diffusion_models
wget -q --show-progress https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_animate_14B_bf16.safetensors

cd ${MODEL_DIR}/unet
wget -q --show-progress https://huggingface.co/QuantStack/Wan2.2-Animate-14B-GGUF/resolve/main/Wan2.2-Animate-14B-Q4_K_M.gguf

cd ${MODEL_DIR}/vae
wget -q --show-progress https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/Wan2_1_VAE_fp32.safetensors

cd ${MODEL_DIR}/text_encoders
wget -q --show-progress https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/umt5-xxl-enc-fp8_e4m3fn.safetensors
wget -q --show-progress https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/umt5-xxl-enc-bf16.safetensors

cd ${MODEL_DIR}/clip_vision
wget -q --show-progress https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/clip_vision/clip_vision_h.safetensors

cd ${MODEL_DIR}/Loras
wget -q --show-progress https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/LoRAs/Wan22_relight/WanAnimate_relight_lora_fp16.safetensors
wget -q --show-progress https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/Lightx2v/lightx2v_I2V_14B_480p_cfg_step_distill_rank256_bf16.safetensors

cd ${MODEL_DIR}/detection
wget -q --show-progress https://huggingface.co/JunkyByte/easy_ViTPose/resolve/main/onnx/wholebody/vitpose-l-wholebody.onnx
wget -q --show-progress https://huggingface.co/Wan-AI/Wan2.2-Animate-14B/resolve/main/process_checkpoint/det/yolov10m.onnx

cd ${MODEL_DIR}/sams
wget -q --show-progress https://huggingface.co/VeryAladeen/Sec-4B/resolve/main/SeC-4B-fp16.safetensors

echo "✅ All WanAnimate models downloaded successfully!"

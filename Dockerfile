FROM nvidia/cuda:12.1.1-cudnn8-runtime-ubuntu22.04

RUN apt-get update && apt-get install -y --no-install-recommends     git curl python3 python3-pip ffmpeg build-essential     && rm -rf /var/lib/apt/lists/*

RUN ln -sf /usr/bin/python3 /usr/bin/python

WORKDIR /opt/comfyui

COPY . .

RUN pip install --upgrade pip setuptools wheel
RUN pip install -r requirements.txt

ENV MODEL_DIR=/models
RUN mkdir -p ${MODEL_DIR}

COPY docker/start.sh /opt/start.sh
COPY docker/download_models.sh /opt/download_models.sh
RUN chmod +x /opt/start.sh /opt/download_models.sh

EXPOSE 8188

ENV PYTHONUNBUFFERED=1

CMD ["/opt/start.sh"]

FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu22.04

RUN apt-get update && apt-get install -y \
    git \
    cmake \
    build-essential \
    libopenblas-dev \
    liblapack-dev \
    libatlas-base-dev \
    gfortran

# add other essential stuff of command utilities
RUN apt-get install -y \
    curl \
    wget \
    vim \
    tmux \
    htop \ 
    tree \
    unzip \
    zip \
    p7zip-full \
    p7zip-rar \
    rar \
    unrar

RUN apt-get install -y \
    python3 \
    python3-pip \
    python3-dev \
    python3-setuptools \
    python3-wheel

RUN pip install --upgrade pip

# Install git and system dependencies for opencv-python
RUN apt-get update && apt-get install -y git \
    && apt-get update && apt-get install -y libgl1 libglib2.0-0
RUN apt-get install -y ffmpeg libturbojpeg


# create a directory /resources
RUN mkdir -p /resources

# move to that work dir
WORKDIR /resources

RUN apt install -y python3.10-venv


SHELL ["/bin/bash", "-c"]

# create a virtual environment
RUN python3 -m venv mm_env && \
    source mm_env/bin/activate && \
    pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118 && \
    pip3 install openmim && \
    mim install mmengine && \
    pip3 install wheel && \
    mim install "mmcv==2.2.0" && \
    git clone --branch v3.1.0 https://github.com/open-mmlab/mmdetection.git && \
    cd mmdetection && \
    pip3 install -e . && cd .. && \
    git clone --branch v1.0.0 https://github.com/open-mmlab/mmpose.git && \
    cd mmpose && \
    pip3 install -e . && cd ..


# RUN pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118

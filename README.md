# Introduction

This project aims to create an automated palm reading fortune teller using artificial intelligence. The system will:

1. Capture images of users' palms using a camera connected to the Raspberry Pi
2. Process and segment the hand images to isolate the palm lines and features
3. Send the processed palm images to ChatGPT via API for analysis
4. Return personalized daily fortune readings based on the AI's interpretation



Some pre-requisites on wsl

for mmcv. 
```
sudo apt install ffmpeg libsm6 libxext6
```


# pre-requisites for gpu pc
```
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121
pip install -U openmim
pip install --upgrade setuptools
mim install mmengine
mim install "mmcv>=2.0.1"
mim install "mmdet>=3.1.0"
```


# Deployment 
For deployment, I think it is best to use docker. 

Using the tag `openmmlab/mmdeploy:ubuntu20.04-cuda11.8-mmdeploy` since it is the latest version. 
```
export TAG=openmmlab/mmdeploy:ubuntu20.04-cuda11.8-mmdeploy
docker pull $TAG
```

usage:
```
docker run -it --gpus all --rm -v /home/jason/hdd/side_projects/learning_stuff/annotated-transformer/:/workspace/annotated-transformer $TAG bash
```

Make sure that nvidia drivers are installed in the docker container. 
```
# for ubuntu 24.04, use this link -> https://www.server-world.info/en/note?os=Ubuntu_24.04&p=nvidia&f=3
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-toolkit.gpg
curl -fsSL https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | sudo tee /etc/apt/sources.list.d/nvidia-toolkit.list

sudo sed -i -e "s/^deb/deb \[signed-by=\/usr\/share\/keyrings\/nvidia-toolkit.gpg\]/g" /etc/apt/sources.list.d/nvidia-toolkit.list
sudo apt update
sudo apt -y install nvidia-container-toolkit
systemctl restart docker
```


```
docker run --gpus=all -d --mount type=bind,source=/hdd/side_projects/,target=/hdd/side_projects/ --restart unless-stopped --name mm_deploy_container $TAG sleep infinity
```


# mm docker image

```
docker build -t mm_docker_env:v1 .
```
run command
```
docker run --gpus=all -d --mount type=bind,source=/hdd/side_projects/,target=/hdd/side_projects/ --restart unless-stopped --name mm_pose_container mm_docker_env:v1 sleep infinity
```


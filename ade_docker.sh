#!/bin/bash

docker inspect --format '{{json .Config.Labels}}' registry.gitlab.com/nubodev/ade:ubuntu
docker inspect --format '{{json .Config.Labels}}' registry.gitlab.com/nubodev/ade:ubuntu
docker inspect --format '{{json .Config.Labels}}' registry.gitlab.com/nubodev/vscode:1.44
docker inspect --format '{{json .Config.Labels}}' registry.gitlab.com/nubodev/vscode:1.44
docker ps --format '{{.Names}}'
docker rm -f ade
docker ps -a --format '{{.Names}}'
docker start ade_registry.gitlab.com_nubodev_vscode_1.44
docker version --format '{{.Server.Version}}'
docker image inspect --format '{{.Id}}' registry.gitlab.com/nubodev/ade:ubuntu
docker inspect --format '{{json .Config.Labels}}' registry.gitlab.com/nubodev/ade:ubuntu
docker inspect --format '{{json .Config.Labels}}' registry.gitlab.com/nubodev/ade:ubuntu
docker inspect --format '{{json .Config.Labels}}' registry.gitlab.com/nubodev/vscode:1.44
docker inspect --format '{{json .Config.Labels}}' registry.gitlab.com/nubodev/vscode:1.44
docker run -h ade --detach --name ade --env COLORFGBG --env DISPLAY --env EMAIL --env GIT_AUTHOR_EMAIL --env GIT_AUTHOR_NAME --env GIT_COMMITTER_EMAIL --env GIT_COMMITTER_NAME --env SSH_AUTH_SOCK --env TERM --env TIMEZONE=America/Toronto --env USER=nubot --env GROUP=nubot --env USER_ID=1000 --env GROUP_ID=1000 --env VIDEO_GROUP_ID=44 -v /dev/dri:/dev/dri -v /dev/shm:/dev/shm -v /tmp/.X11-unix:/tmp/.X11-unix -v /media/nubot/Seagate/Nubonetics/workspace/NuboLearning:/home/nubot --env ADE_CLI_VERSION=4.2.0dev --env ADE_HOME_HOSTPATH=/media/nubot/Seagate/Nubonetics/workspace/NuboLearning --label ade_version=4.2.0dev -v /home/nubot/.ssh:/home/nubot/.ssh -v /run/user/1000/keyring/ssh:/run/user/1000/keyring/ssh --volumes-from ade_registry.gitlab.com_nubodev_vscode_1.44:rw --label 'ade_volumes_from=["ade_registry.gitlab.com_nubodev_vscode_1.44"]' --gpus all --env NVIDIA_VISIBLE_DEVICES=all --env NVIDIA_DRIVER_CAPABILITIES=compute,utility,graphics,display --env LD_LIBRARY_PATH=/usr/local/nvidia/lib64 --cap-add=SYS_PTRACE --net=host --privileged --add-host ade:127.0.0.1 --env ADE_IMAGE_ADE_FQN=registry.gitlab.com/nubodev/ade:ubuntu --env ADE_IMAGE_ADE_COMMIT_SHA= --env ADE_IMAGE_ADE_COMMIT_TAG= --env ADE_IMAGE_VSCODE_FQN=registry.gitlab.com/nubodev/vscode:1.44 --env ADE_IMAGE_VSCODE_COMMIT_SHA= --env ADE_IMAGE_VSCODE_COMMIT_TAG= --label 'ade_images=[{"fqn": "registry.gitlab.com/nubodev/ade:ubuntu", "commit_sha": "", "commit_tag": ""}, {"fqn": "registry.gitlab.com/nubodev/vscode:1.44", "commit_sha": "", "commit_tag": ""}]' registry.gitlab.com/nubodev/ade:ubuntu
#docker inspect '--format='"'"'{{ .Config.Hostname }}'"'"'' bc9e6e639ba41a5d65eef536a96e59d3f8a7e0602cbb409c76f364514686dc12
xhost +local:'ade'
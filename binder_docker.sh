#!/bin/bash

docker pull registry.gitlab.com/nubodev/binders:latest
docker run -it --name repo2docker -p 8888:8888 registry.gitlab.com/nubodev/binders:latest jupyter notebook --ip 0.0.0.0
#!/bin/bash
docker volume create \
  --driver local \
  --opt type=nfs \
  --opt o=addr=192.168.1.100,rw \
  --opt device=:/exported/path \
  mynfs

docker run -it --rm -v mynfs:/data alpine sh

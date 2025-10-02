#!/bin/bash
docker volume create myvol
docker run --rm -v myvol:/data alpine sh -c "echo HelloWorld > /data/file.txt"
docker run --rm -v myvol:/data alpine cat /data/file.txt

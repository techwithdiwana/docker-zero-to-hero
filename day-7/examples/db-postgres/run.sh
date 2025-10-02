#!/bin/bash
docker volume create pgdata
docker run -d --name postgres-db -e POSTGRES_PASSWORD=secret -v pgdata:/var/lib/postgresql/data postgres:14
docker ps

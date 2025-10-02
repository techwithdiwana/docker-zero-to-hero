#!/bin/bash
echo "Cleaning up unused volumes..."
docker volume prune -f

#!/usr/bin/env bash
set -euo pipefail
echo "== Build nonroot-demo image =="
docker build -t nonroot-demo:latest -f Dockerfile .
echo "== Run nonroot-demo (should print 'appuser') =="
docker run --rm nonroot-demo:latest
echo "== Capability test: try bind 80 as non-root (expected to fail) =="
docker run --rm --user 1000 python:3.11-slim python -c "import socket; s=socket.socket(); s.bind(('0.0.0.0',80))" || echo "Bind failed as expected"
echo "== Capability test: with NET_BIND_SERVICE (expected to succeed) =="
docker run --rm --user 1000 --cap-add=NET_BIND_SERVICE python:3.11-slim python -c "import socket; s=socket.socket(); s.bind(('0.0.0.0',80)); print('BOUND')" || echo "Bind test failed"
echo "== Seccomp test: run alpine with custom seccomp =="
docker run --rm --security-opt seccomp=./custom-seccomp.json alpine:3.18 sh -c "echo seccomp-ok"
echo "== If Trivy is installed, run a quick scan (ignore errors if not installed) =="
if command -v trivy >/dev/null 2>&1; then
  trivy image nginx:latest || true
else
  echo "Trivy not installed - skipping scan"
fi
echo "== Done =="

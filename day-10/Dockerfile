# nonroot-demo Dockerfile
FROM python:3.11-slim
RUN useradd -m -s /bin/bash appuser
WORKDIR /home/appuser
USER appuser
CMD [ "whoami" ]

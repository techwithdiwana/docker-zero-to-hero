# 🛡️ Day-10: Docker Security
**Docker Zero to Hero Series — by [Tech With Diwana](https://github.com/techwithdiwana)**

---

<p align="center">
  <img src="https://img.shields.io/badge/Level-Intermediate-blue?style=for-the-badge"/>
  <img src="https://img.shields.io/badge/Topic-Docker%20Security-orange?style=for-the-badge"/>
  <img src="https://img.shields.io/badge/Tools-Trivy%2C%20Anchore%2C%20Seccomp-green?style=for-the-badge"/>
  <img src="https://img.shields.io/badge/Series-Day--10-red?style=for-the-badge"/>
  <img src="https://img.shields.io/badge/Author-Tech%20With%20Diwana-yellow?style=for-the-badge"/>
</p>

---

## 🎯 Overview
Security is one of the most critical aspects of containerized environments.  
In this session, we’ll explore **how to secure Docker containers** — from non-root users to image scanning and secret management.

---

## 🧱 Topics Covered

### 🔹 1. Run Containers as Non-Root Users
By default, containers run as the **root user**, which can be risky.  
To reduce risk, always create a **non-root user** inside the Docker image.

#### 🧩 Example:
```Dockerfile
FROM ubuntu:22.04

# Create a new user
RUN useradd -m appuser

# Switch to non-root user
USER appuser

WORKDIR /home/appuser
CMD ["bash"]
```

✅ Now your container runs with **limited privileges**, reducing attack surface.

---

### 🔹 2. Capabilities & Seccomp
Linux **capabilities** split root privileges into smaller chunks — e.g., `NET_ADMIN`, `SYS_ADMIN`.

Docker allows you to drop or add specific capabilities using `--cap-drop` or `--cap-add`.

#### 🧩 Example:
```bash
# Drop all capabilities except those needed
docker run --cap-drop=ALL --cap-add=NET_BIND_SERVICE nginx
```

#### 🛡️ Seccomp (Secure Computing Mode)
`seccomp` filters system calls that containers can make.

- Default Docker seccomp profile blocks dangerous syscalls.
- You can apply your own custom seccomp profile:

```bash
docker run --security-opt seccomp=custom-seccomp.json nginx
```

---

### 🔹 3. Docker Content Trust (DCT)
DCT ensures that you **only use signed images**.  
It verifies image signatures before pulling or running images.

#### ✅ Enable Docker Content Trust:
```bash
export DOCKER_CONTENT_TRUST=1
docker pull alpine:latest
```

If the image isn’t signed, Docker will **refuse to pull** it.

---

### 🔹 4. Image Scanning (Trivy, Anchore)
Scanning images helps identify **vulnerabilities (CVEs)** in packages and libraries.

#### 🔍 Scan with Trivy
Install Trivy:
```bash
sudo apt install trivy -y
```

Scan an image:
```bash
trivy image nginx:latest
```

#### 🔍 Scan with Anchore CLI
```bash
anchore-cli image add nginx:latest
anchore-cli image vuln nginx:latest all
```

🔐 Use these tools in your **CI/CD pipeline** for continuous vulnerability scanning.

---

### 🔹 5. Secrets Management
Never hardcode passwords, API keys, or tokens inside your Dockerfile.  
Use Docker secrets or environment variables securely.

#### 🧩 Example using Docker Secrets (in Swarm mode):
```bash
echo "MyDBPassword123" | docker secret create db_password -
docker service create --name myapp --secret db_password nginx
```

Inside the container:
```
/run/secrets/db_password
```

---

### 🔹 6. Namespaces & Cgroups Basics
#### 🧭 Namespaces
Namespaces isolate resources like:
- **PID** – process IDs  
- **NET** – networking stack  
- **MNT** – mounts/filesystems  
- **UTS** – hostname/domain  
- **IPC** – interprocess communication  

➡️ They ensure containers don’t see each other’s processes or files.

#### ⚙️ Cgroups (Control Groups)
Cgroups limit and monitor **resource usage** (CPU, memory, I/O).

Example:
```bash
docker run -d --memory=256m --cpus=0.5 nginx
```

This container:
- Uses max 256MB RAM  
- Gets half a CPU core

---

## 🧰 Best Practices Summary

| # | Security Practice | Description |
|---|------------------|-------------|
| 1 | Use non-root users | Avoid running containers as root |
| 2 | Limit capabilities | Drop unnecessary privileges |
| 3 | Use seccomp profiles | Block dangerous syscalls |
| 4 | Enable DCT | Pull only trusted signed images |
| 5 | Scan images | Use Trivy or Anchore regularly |
| 6 | Manage secrets safely | Use Docker secrets or vaults |
| 7 | Resource control | Apply namespaces & cgroups |

---

## ⚡ Hands-On Challenge
1. Create a Dockerfile that:
   - Runs as non-root  
   - Uses `trivy` to scan itself  
   - Drops all capabilities except `NET_BIND_SERVICE`  

2. Push your secure image to Docker Hub.

3. Enable Docker Content Trust and verify image signatures.

---

## 📽️ Watch Full Tutorial
🎥 YouTube: [Docker Security (Day-10) — Tech With Diwana](https://youtube.com/@techwithdiwana)

---

<p align="center">
  <img src="https://img.shields.io/github/stars/techwithdiwana/docker-zero-to-hero?style=for-the-badge"/>
  <img src="https://img.shields.io/github/forks/techwithdiwana/docker-zero-to-hero?style=for-the-badge"/>
  <img src="https://img.shields.io/badge/Subscribe-YouTube-red?style=for-the-badge&logo=youtube"/>
</p>

---

💬 **Author:** *Diwana Kumar (Tech With Diwana)*  
📅 **Series:** Docker Zero to Hero | **Day-10**  
🔗 Follow for daily DevOps learning: [GitHub](https://github.com/techwithdiwana) | [YouTube](https://youtube.com/@techwithdiwana)

# 🚀 Day-1: Introduction to Containers (Docker Basics)

## 1. Virtualization vs Containerization

### 🔹 Virtualization
- Virtual Machines (VMs) ek **hypervisor** ke upar chalte hain.
- Har VM ka apna **Operating System + Binaries + Libraries + App Code** hota hai.
- Heavy hote hain aur boot time zyada lagta hai.

### 🔹 Containerization
- Containers host ka **OS kernel share karte hain**.
- Sirf **app + dependencies** package hote hain.
- Lightweight, fast aur resource-efficient hote hain.

| Feature | Virtual Machines | Containers |
|---------|------------------|------------|
| Abstraction | Hardware level | OS level |
| OS per instance | Yes (Guest OS) | No (shared kernel) |
| Resource usage | High | Low |
| Startup time | Minutes | Seconds |
| Portability | Limited | Highly portable |

---

## 2. Docker — Kya hai & Kyun Use Karte Hain

👉 **Definition (Official Docker Docs):**  
“Docker is an open platform for developing, shipping, and running applications.”

### 🔹 Why Docker?
- **Consistency**: “Works on my machine” problem khatam.
- **Portability**: Laptop → Server → Cloud → Same image, same result.
- **Efficiency**: Ek server pe multiple apps bina heavy resources consume kiye.
- **Faster Deployment**: Containers boot in seconds.

---

## 3. Architecture Comparison

### 🔹 VM Architecture
```
[Hardware]
   ↳ Host OS
        ↳ Hypervisor
             ↳ VM1 → Guest OS → App1
             ↳ VM2 → Guest OS → App2
```

### 🔹 Container Architecture
```
[Hardware]
   ↳ Host OS
        ↳ Docker Engine
             ↳ Container1 → App1 + Dependencies
             ↳ Container2 → App2 + Dependencies
```

✅ **Key Difference:**  
Containers **don’t need a full OS**, they share the host OS kernel.

---

## 4. Docker Engine & Daemon

**Docker Engine Components:**

1. **Docker Daemon (`dockerd`)**
   - Background service that builds, runs, and manages containers.

2. **Docker CLI (`docker`)**
   - User commands like `docker run nginx`, `docker ps`.
   - CLI → REST API → Daemon.

3. **Docker REST API**
   - Communication bridge between CLI and Daemon.

4. **Docker Registry**
   - Stores & distributes images (e.g., Docker Hub, private registry).

---

## 5. Example Snippets

### 🔹 Run First Container
```bash
# Pull & run nginx container
docker run -d -p 8080:80 nginx
```

### 🔹 Check Running Containers
```bash
docker ps
```

### 🔹 Stop Container
```bash
docker stop <container_id>
```

---

## 📚 References

- [Docker Overview (Official Docs)](https://docs.docker.com/get-started/docker-overview/)
- [What is a Container? (Docker.com)](https://www.docker.com/resources/what-container/)
- [Containers vs VMs (Microsoft Docs)](https://learn.microsoft.com/en-us/virtualization/windowscontainers/about/containers-vs-vm)
- [Docker Architecture (Cherry Servers)](https://www.cherryservers.com/blog/a-complete-overview-of-docker-architecture)

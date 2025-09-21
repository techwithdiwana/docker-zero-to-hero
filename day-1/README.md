# Docker Day-1: Introduction to Containers

![Watermark](tech_with_diwana.png)

## 1. Introduction to Containers

### 🔹 Virtualization vs Containerization
- **Virtualization (VMs):**
  - Hypervisor ke upar har ek Virtual Machine ka apna **Guest OS** hota hai.
  - Heavy hote hain, zyada RAM/CPU lete hain, aur boot time slow hota hai.
- **Containerization:**
  - Host OS ke **kernel ko share** karte hain, sirf app + dependencies ek isolated environment me run hoti hain.
  - Lightweight hote hain, fast startup aur kam resources use karte hain.

📸 Diagram:  
![VM vs Container](vm_vs_container.png)

---

### 🔹 Docker kya hai aur kyu use karte hain?
- Docker ek **containerization platform** hai jo apps ko build, ship aur run karne me help karta hai.
- Ek baar app ko Docker image me package karo → kahin bhi same tarike se run karo.
- Developers ke liye dependency conflicts ka problem solve karta hai.
- CI/CD aur microservices me sabse zyada use hota hai.

📸 Diagram:  
![Docker Whale](docker_whale.png)

---

### 🔹 Container Architecture vs VM Architecture
- **VM Architecture:** Hardware → Hypervisor → Guest OS → App
- **Container Architecture:** Hardware → OS Kernel → Docker Engine → Containers

📸 Diagram:  
![VM vs Container](vm_vs_container.png)

---

### 🔹 Docker Engine & Daemon
- **Docker Client (CLI):** Commands dene ke liye use hota hai.
- **Docker Daemon (`dockerd`):** Background service jo containers banata aur manage karta hai.
- **Docker Hub:** Public registry jahan se images pull ki jaati hain.

📸 Diagram (Architecture):  
![Docker Architecture](docker_architecture.png)

---

✍️ Prepared By: **Tech With Diwana**

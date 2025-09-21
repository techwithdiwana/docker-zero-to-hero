# 🚀 Docker Day-1: Introduction to Containers  

![Made with Love](https://img.shields.io/badge/Made%20with-%E2%9D%A4-red)
![Docker](https://img.shields.io/badge/Powered%20by-Docker-blue)
![Beginner Friendly](https://img.shields.io/badge/Level-Beginner-green)
![Tech With Diwana](https://img.shields.io/badge/Brand-Tech%20With%20Diwana-orange)

---

## 1. Introduction to Containers  

Containers ek **lightweight environment** hote hain jaha applications aur unki dependencies ek isolated environment me run hoti hain.  
Yeh developers ko ek consistent environment dete hain jo **development → testing → production** tak same tarike se kaam karta hai.  

---

## 🔹 Virtualization vs Containerization  

- **Virtualization (VMs):**
  - Virtual Machines run on a **Hypervisor**.
  - Har VM ka apna **Guest OS** hota hai.
  - Heavy → Zyada CPU/RAM lagta hai, aur startup slow hota hai.  

- **Containerization:**
  - Containers **Host OS Kernel** ko share karte hain.
  - Lightweight → Fast startup, kam resource usage.
  - Ek server par multiple containers easily run karte hain.  

📸 Diagram:  
<p align="center">
  <img src="vm_vs_container.png" alt="VM vs Container" width="650"/>
</p>

---

## 🔹 Docker kya hai aur kyu use karte hain?  

- Docker ek **Containerization Platform** hai.  
- Ek baar app ko Docker image me package karo → kahin bhi run karo (consistency).  
- Developers ke liye **dependency conflicts solve** karta hai.  
- **Microservices aur CI/CD pipelines** me sabse zyada use hota hai.  

📸 Diagram:  
<p align="center">
  <img src="docker_whale.png" alt="Docker Whale" width="500"/>
</p>

---

## 🔹 Container Architecture vs VM Architecture  

- **VM Architecture:**  
  Physical Server → Hypervisor → Guest OS → Applications  

- **Container Architecture:**  
  Physical Server → Host OS → Docker Engine → Containers  

📸 Diagram:  
<p align="center">
  <img src="vm_vs_container.png" alt="VM vs Container" width="650"/>
</p>

---

## 🔹 Docker Engine & Daemon  

- **Docker Client (CLI):**
  - Jaha hum commands run karte hain → `docker build`, `docker run`, `docker pull`.  
- **Docker Daemon (`dockerd`):**
  - Background service jo containers ko create, run aur manage karta hai.  
- **Images:**
  - Templates (read-only) jo containers banane ke liye use hote hain.  
- **Containers:**
  - Running instances of Docker images.  
- **Registry (Docker Hub):**
  - Public/private store jaha se images **pull** aur **push** karte hain.  

📸 Diagram:  
<p align="center">
  <img src="docker_architecture.png" alt="Docker Architecture" width="750"/>
</p>

---

## 🌐 Connect with Me  

- 🎥 **YouTube:** [Tech With Diwana](https://www.youtube.com/@TechWithDiwana)  
- 💻 **GitHub:** [techwithdiwana](https://github.com/techwithdiwana/)  
- 💼 **LinkedIn:** [Tech With Diwana](https://linkedin.com/in/techwithdiwana)  

---

✍️ Prepared By: **Tech With Diwana**

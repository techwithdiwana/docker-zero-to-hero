# 🚀 Docker Day-1: Introduction to Containers  

![Made with Love](https://img.shields.io/badge/Made%20with-%E2%9D%A4-red) 
![Docker](https://img.shields.io/badge/Powered%20by-Docker-blue) 
![Beginner Friendly](https://img.shields.io/badge/Level-Beginner-green) 
![Tech With Diwana](https://img.shields.io/badge/Brand-Tech%20With%20Diwana-orange)

---

## 1. Virtualization vs Containerization  
- **Virtualization (VMs):**
  - Har VM ka apna **Guest OS** hota hai.
  - Zyada heavy, CPU/RAM consume karta hai.  
- **Containerization:**
  - Containers **Host OS kernel share** karte hain.
  - Lightweight aur fast hote hain.  

📸 Diagrams:  
<p align="center">
  <img src="vm_vs_container.png" alt="VM vs Container" width="400"/>
  <img src="docker_whale.png" alt="Docker Whale" width="400"/>
</p>

---

## 2. Docker kya hai aur kyu use karte hain?  
- Docker ek **containerization platform** hai jo apps ko build, ship aur run karne me madad karta hai.  
- Ek baar image banao → kahin bhi chalao.  
- Microservices aur CI/CD pipelines me sabse useful.  

📸 Diagram:  
<p align="center">
  <img src="docker_whale.png" alt="Docker Whale" width="450"/>
</p>

---

## 3. Container Architecture vs VM Architecture  
- **VM Architecture:** Hardware → Hypervisor → Guest OS → Apps  
- **Container Architecture:** Hardware → Host OS → Docker Engine → Containers  

📸 Diagrams:  
<p align="center">
  <img src="vm_vs_container.png" alt="VM vs Container" width="400"/>
  <img src="docker_architecture.png" alt="Docker Architecture" width="400"/>
</p>

---

## 4. Docker Engine & Daemon  
- **Docker Client (CLI)** → Commands run karta hai.  
- **Docker Daemon (`dockerd`)** → Containers manage karta hai.  
- **Registry (Docker Hub)** → Images store & share karte hain.  

📸 Diagram:  
<p align="center">
  <img src="docker_architecture.png" alt="Docker Architecture" width="600"/>
</p>

---

✍️ Prepared By: **Tech With Diwana**

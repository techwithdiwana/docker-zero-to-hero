# 🚀 Docker Zero to Hero — Day 9: Docker Swarm

[![Docker](https://img.shields.io/badge/Docker-Swarm-blue?logo=docker&logoColor=white)](https://www.docker.com/)
[![Level](https://img.shields.io/badge/Level-Intermediate-orange)]()
[![Language](https://img.shields.io/badge/Language-YAML%20%26%20CLI-green)]()
[![YouTube](https://img.shields.io/badge/Watch%20on-YouTube-red?logo=youtube)](https://www.youtube.com/@TechWithDiwana)
[![License](https://img.shields.io/badge/License-MIT-lightgrey)]()
[![TechWithDiwana](https://img.shields.io/badge/Made%20by-Tech%20With%20Diwana-black?logo=github)](https://github.com/techwithdiwana)

---

## 📘 Day 9 Agenda
> Learn Docker **Swarm Mode** from zero — build, scale, update, and manage multi-container applications.

### 🔹 Topics Covered
1. Swarm Mode Introduction  
2. Initialize Swarm & Add Worker Nodes  
3. Deploy Services  
4. Scaling Services  
5. Rolling Updates  
6. Stack Deployment  

---

## 🧠 What is Docker Swarm?
Docker **Swarm** is Docker’s native **container orchestration** tool that allows you to:
- Manage multiple Docker hosts as a **single cluster**  
- Deploy & scale services easily  
- Perform **rolling updates** and **load balancing**

> Think of it as Docker’s built-in mini Kubernetes 🚀

---

## 🧱 Step 1 — Launch EC2 Instances

| Node | Name | Type | Role |
|------|------|------|------|
| 1️⃣ | manager-node | t2.micro | Swarm Manager |
| 2️⃣ | worker-node | t2.micro | Swarm Worker |

**Security Group Ports**
```
22 (SSH)
2377 TCP – Swarm management
7946 TCP/UDP – node communication
4789 UDP – overlay network
80, 8080 TCP – web service
```

---

## 🐳 Step 2 — Install Docker
On **both** instances:
```bash
sudo apt update -y
sudo apt install docker.io -y
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker ubuntu
```
Re-login to apply user group changes.

---

## 🌐 Step 3 — Initialize Swarm (Manager Node)
```bash
docker swarm init --advertise-addr <MANAGER_PRIVATE_IP>
```

You’ll see a join token output like:
```
docker swarm join --token <TOKEN> <MANAGER_PRIVATE_IP>:2377
```

---

## 🤝 Step 4 — Join Worker Node
SSH into worker node and run:
```bash
docker swarm join --token <TOKEN> <MANAGER_PRIVATE_IP>:2377
```

✅ Verify:
```bash
docker node ls
```

---

## 🧩 Step 5 — Deploy First Service
```bash
docker service create --name web --replicas 2 -p 8080:80 nginx
docker service ls
docker service ps web
```

👉 Visit: `http://<ANY_NODE_PUBLIC_IP>:8080` to see Nginx page 🎉

---

## 📈 Step 6 — Scale Services
```bash
docker service scale web=4
docker service ps web
```

---

## 🔄 Step 7 — Rolling Updates
```bash
docker service update --image nginx:latest web
```

Advanced:
```bash
docker service update --update-delay 10s --update-parallelism 1 --image nginx:1.25 web
```

---

## 📦 Step 8 — Stack Deployment
Create **`docker-compose.yml`**
```yaml
version: "3.8"

services:
  frontend:
    image: nginx:latest
    ports:
      - "8080:80"
    deploy:
      replicas: 3
      restart_policy:
        condition: on-failure
      update_config:
        parallelism: 1
        delay: 10s
```

Deploy:
```bash
docker stack deploy -c docker-compose.yml mystack
docker stack ls
docker stack services mystack
docker stack ps mystack
```

Remove:
```bash
docker stack rm mystack
```

---

## 🧰 Useful Commands

| Purpose | Command |
|----------|----------|
| Init Swarm | `docker swarm init` |
| Join Worker | `docker swarm join --token <token>` |
| List Nodes | `docker node ls` |
| List Services | `docker service ls` |
| Scale Service | `docker service scale web=5` |
| Remove Service | `docker service rm web` |
| Leave Swarm | `docker swarm leave --force` |

---

## 🧠 Recap
✅ Swarm Mode Intro  
✅ Initialize & Join Nodes  
✅ Deploy & Scale Services  
✅ Rolling Updates  
✅ Stack Deployment  

---

## 📺 Watch Full Tutorial  
🎥 **Docker Zero to Hero — Day 9: Docker Swarm (Hindi)**  
👉 [Watch on YouTube](https://www.youtube.com/@TechWithDiwana)

---

## 💬 Connect with Me
[![GitHub](https://img.shields.io/badge/GitHub-TechWithDiwana-black?logo=github)](https://github.com/techwithdiwana)
[![YouTube](https://img.shields.io/badge/YouTube-Tech%20With%20Diwana-red?logo=youtube)](https://www.youtube.com/@TechWithDiwana)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue?logo=linkedin)](https://www.linkedin.com)
[![Instagram](https://img.shields.io/badge/Instagram-Follow-pink?logo=instagram)](https://instagram.com)

---

## ⚡ Tags
`#DockerSwarm` `#DockerZeroToHero` `#TechWithDiwana` `#DevOps` `#DockerCompose` `#SwarmCluster`

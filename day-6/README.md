![Day-6 Docker Networking Banner](assets/day6-banner.png)

<p align="center">
  <a href="https://www.linkedin.com/in/devopswithdiwana">
    <img src="https://img.shields.io/badge/LinkedIn-Connect-blue?logo=linkedin&style=for-the-badge" />
  </a>
  <img src="https://img.shields.io/badge/Docker-Networking-blue?logo=docker&style=for-the-badge" />
  <img src="https://img.shields.io/badge/Network-Bridge-green?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Network-Host-orange?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Network-None-red?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Network-Overlay-purple?style=for-the-badge" />
</p>

# 📘 Day-06: Docker Networking

---

## 🎯 Topics Covered
- Default networks: **bridge, host, none**
- Custom networks
- Container-to-container communication
- DNS resolution inside containers
- Port mapping (`-p hostPort:containerPort`)
- Linking containers (deprecated but interview knowledge)
- Overlay network (multi-host, Swarm)
- Linux namespaces aur Docker isolation
- How to check which network a container is using

---

## 🔹 Before We Start: `-dit` ka Matlab
- `-d` → Detached mode (background me run hota hai)  
- `-i` → Interactive (STDIN open rahta hai)  
- `-t` → TTY allocate karta hai (terminal jaise interface)  

👉 Together: `docker run -dit ...` = container background me chalega but attach bhi ho sakta hai.

---

## 🔹 1. Bridge Network (Default)
```bash
docker run -dit --name c1 busybox
docker run -dit --name c2 busybox
docker inspect -f '{{ .NetworkSettings.IPAddress }}' c1
docker exec -it c2 ping -c 3 <c1_ip>
```
- Containers IP se communicate karte hain (name se nahi).  
- Single host tak limited.  
- **Use-case:** Local testing, standalone containers.

---

## 🔹 2. Host Network
```bash
docker run -d --name nginx-host --network host nginx
```
👉 Access: `http://localhost:80`  
- Port mapping ki zaroorat nahi.  
- Linux only, isolation kam.  
- **Use-case:** High performance workloads.

---

## 🔹 3. None Network
```bash
docker run -dit --name isolated --network none busybox
docker exec -it isolated ifconfig
```
- No internet, no inter-container communication.  
- **Use-case:** Security-sensitive workloads.

---

## 🔹 4. Custom Bridge Network
```bash
docker network create mynet
docker run -dit --name web1 --network mynet busybox
docker run -dit --name web2 --network mynet busybox
docker exec -it web1 ping -c 3 web2
```
- Containers name se communicate kar sakte hain.  
- **Use-case:** Multi-container apps on same host.

---

## 🔹 5. Overlay Network (Swarm / Multi-Host)
```bash
docker swarm init
docker network create -d overlay myoverlay
docker service create --name webapp --network myoverlay -p 8081:80 nginx
```
- Multi-host container communication.  
- Needs Swarm mode.  
- **Use-case:** Production, distributed microservices.

---

## 🔹 6. Linking Containers (Deprecated)
```bash
docker run -dit --name db busybox
docker run -dit --name app --link db busybox
```
- Old method, ab networks prefer karte hain.  
- **Use-case:** Only interview knowledge.

---

## 🔹 7. Kaise Check Karein Container Ka Network?
```bash
docker network ls                # List all networks
docker network inspect mynet     # Inspect a specific network
docker inspect <container>       # Inspect container details
docker inspect -f '{{range $k,$v := .NetworkSettings.Networks}}{{$k}} -> {{$v.IPAddress}}{{"\n"}}{{end}}' <container>
```

---

## 🔹 8. Linux Namespaces in Docker
- **PID, NET, MNT, UTS, IPC, USER** → isolation ke liye use hote hain.

```bash
pid=$(docker inspect -f '{{.State.Pid}}' <container>)
ls -l /proc/$pid/ns/
nsenter --target $pid --net ip a
```

---

## 🔹 9. Quick Comparison Table

| Network | Best For | Limitation |
|---------|----------|------------|
| Bridge (default) | Simple, single-host containers | No name-based DNS |
| Custom Bridge | Multi-container apps (same host) | Single host only |
| Host | High performance, monitoring tools | No isolation, Linux only |
| None | Isolated workloads | No networking |
| Overlay | Multi-host microservices | Needs Swarm |

---

## 📊 Visual Comparison

![Docker Network Comparison](assets/day6-network-comparison.png)

---

## ✅ Conclusion
Day-6 me humne dekha:  
- Docker ke saare networks (bridge, host, none, custom, overlay)  
- Inke **use-cases + limitations**  
- Container communication aur DNS resolution  
- Linux namespaces aur isolation concepts  
- Kaise check karein container kaunse network me chal raha hai  

👉 Ab aap confidently **Docker Networking** explain aur demonstrate kar sakte ho in real projects & interviews 🚀

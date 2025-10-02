# 🔥 Day-7: Docker Volumes & Storage 🚀

Welcome to **Day-7** of *Docker Zero to Hero* series!  
In this session, we will master **Docker Volumes & Storage** — the backbone of persistent data in containers.  

---

## 🧭 Table of Contents
- [Introduction](#-1-introduction)
- [Volume vs Bind Mount vs tmpfs](#-2-volume-vs-bind-mount-vs-tmpfs)
- [Creating & Managing Volumes](#-3-creating--managing-volumes)
- [Sharing Data Between Containers](#-4-sharing-data-between-containers)
- [Persistent Storage for Databases](#-5-persistent-storage-for-databases)
- [Volume Drivers (NFS, Cloud)](#-6-volume-drivers-nfs-cloud)
- [Hands-On Examples](#-7-hands-on-examples)
- [Cleanup & Best Practices](#-8-cleanup--best-practices)
- [Summary](#-9-summary)

---

## 🔹 1. Introduction

By default, Docker containers are **ephemeral** → when a container is removed, its data is lost.  

To solve this, Docker provides:
- **Volumes** (Recommended for persistence)
- **Bind Mounts** (Good for dev)
- **tmpfs** (Fast in-memory storage)

---

## 🔹 2. Volume vs Bind Mount vs tmpfs

| Feature              | Volume (Best Practice) | Bind Mount          | tmpfs (RAM Only) |
|----------------------|------------------------|---------------------|------------------|
| Location             | `/var/lib/docker/volumes/...` | Host filesystem path | RAM |
| Lifecycle            | Independent of container | Depends on host path | Ends with container |
| Security             | Safer (managed by Docker) | Full host access (risky) | Safe (RAM only) |
| Best Use             | DB, logs, persistent data | Dev code/config | Cache, session data |

---

## 🔹 3. Creating & Managing Volumes

**Create a volume**
```bash
docker volume create mydata
```

**List all volumes**
```bash
docker volume ls
```

**Inspect a volume**
```bash
docker volume inspect mydata
```

**Remove a volume**
```bash
docker volume rm mydata
```

**Remove unused volumes**
```bash
docker volume prune -f
```

---

## 🔹 4. Sharing Data Between Containers

```bash
# Container 1 writes
docker run -d --name writer -v sharedvol:/data alpine sh -c "echo HelloBhaiya > /data/msg.txt"

# Container 2 reads
docker run --rm --name reader -v sharedvol:/data alpine cat /data/msg.txt
```

Output:
```
HelloBhaiya
```

---

## 🔹 5. Persistent Storage for Databases

**Run Postgres with volume**
```bash
docker volume create pgdata

docker run -d   --name postgres-db   -e POSTGRES_PASSWORD=secret   -v pgdata:/var/lib/postgresql/data   postgres:14
```

- Stop & remove container → data still persists  
- Run a new container with same volume → old data is available ✅  

---

## 🔹 6. Volume Drivers (NFS, Cloud)

Use external storage backends like NFS, AWS EFS, Azure File Share.  

**Example: NFS Volume**
```bash
docker volume create   --driver local   --opt type=nfs   --opt o=addr=192.168.1.100,rw   --opt device=:/exported/path   mynfs
```

Mount into container:
```bash
docker run -it --rm -v mynfs:/data alpine sh
```

---

## 🔹 7. Hands-On Examples

### ✅ Example 1: Basic Volume
```bash
docker volume create myvol
docker run --rm -v myvol:/data alpine sh -c "echo World > /data/hello.txt"
docker run --rm -v myvol:/data alpine cat /data/hello.txt
```

---

### ✅ Example 2: Postgres Database with Volume
```bash
docker volume create pgdata
docker run -d --name pgdb -e POSTGRES_PASSWORD=secret -v pgdata:/var/lib/postgresql/data postgres:14
```

👉 Insert data → stop container → start new → data will persist.

---

### ✅ Example 3: NFS Volume
```bash
docker volume create   --driver local   --opt type=nfs   --opt o=addr=192.168.1.100,rw   --opt device=:/exported/path   mynfs

docker run -it --rm -v mynfs:/data alpine sh
```

---

## 🔹 8. Cleanup & Best Practices

```bash
docker volume prune -f
```

✔️ Always use **named volumes**  
✔️ Use `:ro` (read-only) when needed  
✔️ Avoid mounting sensitive host paths  
✔️ For multi-host setup → use NFS/Cloud volumes  

---

## 🔹 9. Summary

- **Volumes** → Persistent, sharable, managed by Docker  
- **Bind Mounts** → Best for development  
- **tmpfs** → In-memory, fast, ephemeral  
- **Databases** → Always on volumes  
- **Volume Drivers** → Use NFS / Cloud for distributed setup  

---

🎯 **Day-7 Completed Successfully!** 🚀  
Next → **Day-8 (Coming Soon)**  

---

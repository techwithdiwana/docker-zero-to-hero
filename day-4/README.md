# 📘 Day-4: Docker Images  

<p align="center">
  <a href="https://www.youtube.com/@TechWithDiwana">
    <img src="https://img.shields.io/badge/YouTube-TechWithDiwana-red?logo=youtube&logoColor=white" />
  </a>
  <a href="https://www.linkedin.com/in/diwana-kumar-418592128/">
    <img src="https://img.shields.io/badge/LinkedIn-Diwana%20Kumar-blue?logo=linkedin&logoColor=white" />
  </a>
</p>

---

![Day-4 Banner](./day4-banner.png)

---

## 🔹 Topics Covered  

<p align="center">
  <a href="#-1-docker-hub--registry"><img src="https://img.shields.io/badge/Docker%20Hub%20&%20Registry-2496ED?logo=docker&logoColor=white" /></a>
  <a href="#-2-docker-pull--docker-push"><img src="https://img.shields.io/badge/docker%20pull%20%7C%20docker%20push-4B0082?logo=docker&logoColor=white" /></a>
  <a href="#-3-docker-image-layers--unionfs"><img src="https://img.shields.io/badge/Image%20Layers-228B22?logo=stackshare&logoColor=white" /></a>
  <a href="#-4-official-images-vs-custom-images"><img src="https://img.shields.io/badge/Official%20vs%20Custom%20Images-DC143C?logo=docker&logoColor=white" /></a>
  <a href="#-5-inspecting-images"><img src="https://img.shields.io/badge/Docker%20Inspect%20%7C%20History-1E90FF?logo=code&logoColor=white" /></a>
</p>

---

## 🔹 1. Docker Hub & Registry  
- **Docker Hub** → Public registry for storing & sharing images.  
- **Private Registry** → Self-hosted/custom registry.  
- Local registry example:  
  ```bash
  docker run -d -p 5000:5000 --name registry registry:2
  ```
- Naming Convention:  
  ```
  registryhost[:port]/namespace/repo:tag
  ```
  Example: `docker.io/username/myapp:1.0`

---

## 🔹 2. docker pull & docker push  
### ✅ Pull image from Docker Hub
```bash
docker pull nginx:latest
```

### ✅ Run container
```bash
docker run --rm -d -p 8080:80 --name test-nginx nginx:latest
```

### ✅ Tag & Push image to Docker Hub
```bash
docker tag nginx:latest <username>/nginx-test:day4
docker login
docker push <username>/nginx-test:day4
```

### ✅ Push to Local Registry
```bash
docker tag nginx:latest localhost:5000/nginx-test:day4
docker push localhost:5000/nginx-test:day4
docker pull localhost:5000/nginx-test:day4
```

---

## 🔹 3. Docker Image Layers & UnionFS  

### 🔸 Concept
- Each **Dockerfile instruction** (`FROM`, `RUN`, `COPY`, `ADD`) = **new image layer**.  
- **Read-only layers** stacked together using **UnionFS/OverlayFS**.  
- Container adds a **writable top layer** (Copy-on-Write).  
- Benefits: **caching, reuse, efficiency**.  

---

### 🔸 Example Dockerfile with Layer Breakdown
```dockerfile
FROM node:18-alpine          # Layer 1 → Base image (Node.js + Alpine Linux)
WORKDIR /app                 # Layer 2 → Working directory set
COPY package.json yarn.lock . # Layer 3 → Dependencies metadata
RUN yarn install --production # Layer 4 → Node.js dependencies installed
COPY . .                      # Layer 5 → Application source code
CMD ["node", "index.js"]      # Layer 6 → Default command
```

### 🔸 Layer Explanation (Step by Step)
- **Layer 1:** Base OS + Node.js (official image).  
- **Layer 2:** Working directory inside container.  
- **Layer 3:** Copies only dependency files (good for caching).  
- **Layer 4:** Installs dependencies → cached unless `package.json` changes.  
- **Layer 5:** Copies full app code → changes frequently.  
- **Layer 6:** Defines container start command.  

👉 Best Practice: Put less frequently changing steps first for **max layer caching**.

---

## 🔹 4. Official Images vs Custom Images  

- **Official Images**  
  - Trusted, secure, maintained by Docker/community.  
  - Example: `nginx`, `node`, `python`, `mysql`.  
- **Custom Images**  
  - Your app + dependencies.  
  - Built using `Dockerfile`.  

⚡ **Best Practices:**  
- Start with `slim` or `alpine` variants.  
- Use `.dockerignore` to avoid unnecessary files.  
- Use **multi-stage builds** for optimized size.  
- Use version pinning (`node:18-alpine`) for consistency.  

---

## 🔹 5. Inspecting Images  

### List local images
```bash
docker images
```

### Inspect metadata (JSON output)
```bash
docker inspect nginx:latest
```

### Show only layers
```bash
docker image inspect --format='{{json .RootFS.Layers}}' nginx:latest
```

### Image history
```bash
docker history nginx:latest
```

### Save & Load images
```bash
docker save nginx:latest -o nginx.tar
tar -tvf nginx.tar
docker load -i nginx.tar
```

---

## 🔹 🚀 Practice Labs  

✅ **Lab 1:** Pull `nginx:latest`, run container, and inspect metadata.  
✅ **Lab 2:** Build Node.js app with Dockerfile → check layers using `docker history`.  
✅ **Lab 3:** Tag and push your custom image to Docker Hub.  
✅ **Lab 4:** Run local registry and push/pull images.  
✅ **Lab 5:** Save an image as `.tar`, extract and explore its layers.  

---

## 📌 Summary  

- Docker Images = **stack of read-only layers**.  
- Registries (Hub/Private) store & share images.  
- `docker pull` / `docker push` manage image distribution.  
- Layers managed by **UnionFS/OverlayFS** → enable caching & efficiency.  
- **Official Images** are secure & maintained; **Custom Images** are for apps.  
- Use `docker inspect`, `docker history`, `docker save/load` to explore images.  

---

✨ **Follow me for more DevOps content**  
- 📺 [YouTube - TechWithDiwana](https://www.youtube.com/@TechWithDiwana)  
- 💼 [LinkedIn - Diwana Kumar](https://www.linkedin.com/in/diwana-kumar-418592128/)  

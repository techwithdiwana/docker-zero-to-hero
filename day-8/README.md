# 📦 Docker Zero to Hero — Day 8: Docker Compose

![Docker](https://img.shields.io/badge/Docker-Compose-blue?logo=docker&logoColor=white)
![Level](https://img.shields.io/badge/Level-Zero_to_Hero-green)
![Language](https://img.shields.io/badge/YAML-Config-orange)
![Backend](https://img.shields.io/badge/Backend-Node.js-yellow)
![Frontend](https://img.shields.io/badge/Frontend-Nginx-red)
![Database](https://img.shields.io/badge/Database-MongoDB-brightgreen)

> *“Compose helps you define and run multi-container apps — clean, declarative, and powerful.”*

---

## 🚀 What is Docker Compose?

Docker Compose ek tool hai jo tumhe **multi-container applications** ko ek hi file (`docker-compose.yml`) me define karke ek command se run karne deta hai.

```bash
docker-compose up
```

---

## 🧩 What is a Service?

👉 A **Service** is the **definition of how a container should run** in your application.

- Image kaunsa hoga  
- Ports expose karne hain  
- Volumes mount karne hain  
- Environment variables kya hongi  
- Kis network pe chalega  

### ⚡ Tech Analogy (Microservices World)

E-commerce App example:  
- **Frontend Service** → Website (React/Nginx) 🛍️  
- **Backend Service** → API logic (Node.js) ⚙️  
- **Database Service** → MongoDB storage 📦  

| Term | Meaning |
|------|---------|
| **App** | Complete system (frontend + backend + DB) |
| **Service** | Blueprint of one part |
| **Container** | Running instance of service |

---

## 🎯 Day 8 Topics

1. YAML syntax basics  
2. `docker-compose up`, `down`, `logs`, `exec`  
3. Define services (frontend, backend, DB)  
4. Networking in Compose  
5. Environment variables in Compose  
6. Override files  
7. Production vs Development setup  

---

## 📝 Example docker-compose.yml

```yaml
version: "3.9"
services:
  frontend:
    build: ./frontend
    ports:
      - "3000:80"
    depends_on:
      - backend
    networks:
      - app-network

  backend:
    build: ./backend
    ports:
      - "5000:5000"
    environment:
      - DB_HOST=db
      - DB_NAME=${DB_NAME}
    depends_on:
      - db
    networks:
      - app-network

  db:
    image: mongo:6.0
    volumes:
      - db_data:/data/db
    environment:
      - MONGO_INITDB_ROOT_USERNAME=${DB_USER}
      - MONGO_INITDB_ROOT_PASSWORD=${DB_PASS}
    networks:
      - app-network

volumes:
  db_data:

networks:
  app-network:
    driver: bridge
```

---

## ✅ Best Practices

- Use `.env` for secrets  
- Add healthchecks  
- Limit exposed ports  
- Use override files for environments  

---

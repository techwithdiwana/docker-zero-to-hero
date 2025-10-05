# 🛡️ Day-10 — Docker Security
**Docker Zero to Hero — Day 10**  
Beginner-friendly guide. Each topic contains: **WHAT**, **WHY**, **HOW**, **WHEN**, plus examples and quick tests.

<p align="center">
  <img src="https://img.shields.io/badge/Level-Intermediate-blue?style=for-the-badge"/> <img src="https://img.shields.io/badge/Topic-Docker%20Security-orange?style=for-the-badge"/> <img src="https://img.shields.io/badge/Tools-Trivy%2C%20Anchore%2C%20Seccomp-green?style=for-the-badge"/> <img src="https://img.shields.io/badge/Series-Day--10-red?style=for-the-badge"/> <img src="https://img.shields.io/badge/Author-Tech%20With%20Diwana-yellow?style=for-the-badge"/>
</p>

---

## How to use this document
For each topic you will find:
- **WHAT** — short definition  
- **WHY** — why it matters / security impact  
- **HOW** — commands or steps to implement  
- **WHEN** — when to use or common scenarios  
- **EXAMPLE** — ready-to-run snippet  
- **QUICK TEST** — one-liners to verify behavior

---

## 1) Non-root users in containers

**WHAT**  
Run the container main process as a non-root Linux user instead of `root`.

**WHY**  
Running as root increases risk: if the container is compromised, attackers can get more leverage. A non-root process reduces attack surface.

**HOW**
- Create a user in the Dockerfile (`useradd` or `adduser`).
- Use `USER <username>` or `USER <UID:GUID>` in the Dockerfile.
- Combine with `CAP_NET_BIND_SERVICE` if the non-root process needs to bind ports <1024.

**WHEN**
- Always for application containers in production.
- Allow root during image build stages (install packages), but switch to non-root for runtime.

**EXAMPLE (Dockerfile)**
```dockerfile
FROM ubuntu:22.04
RUN useradd -m -s /bin/bash appuser
WORKDIR /home/appuser
USER appuser
CMD ["bash"]
```

**QUICK TEST**
```bash
docker build -t nonroot-demo .
docker run --rm nonroot-demo whoami   # expected: appuser
```

---

## 2) Capabilities & Seccomp

**WHAT**
- **Capabilities**: granular kernel privileges (e.g., `NET_BIND_SERVICE`, `NET_ADMIN`).
- **Seccomp**: syscall filter to allow or block specific kernel calls.

**WHY**
- Capabilities let you give only needed privileges to container processes.
- Seccomp can block dangerous syscalls even if capabilities exist, reducing attack surface.

**HOW**
- Use `--cap-drop=ALL` and `--cap-add=<CAP>` when running containers.
- Apply custom seccomp profile with `--security-opt seccomp=./profile.json`.

**WHEN**
- Default: drop all capabilities and add only required ones.
- Use seccomp for services exposed to untrusted input or running third-party code.

**EXAMPLE (capabilities)**
```bash
docker run --rm -d --cap-drop=ALL --cap-add=NET_BIND_SERVICE -p 80:80 nginx:latest
```

**EXAMPLE (seccomp JSON)**
```json
{
  "defaultAction": "SCMP_ACT_ALLOW",
  "architectures": ["SCMP_ARCH_X86_64"],
  "syscalls": [
    {
      "names": ["ptrace", "perf_event_open"],
      "action": "SCMP_ACT_ERRNO"
    }
  ]
}
```
Run with seccomp:
```bash
docker run --rm --security-opt seccomp=./custom-seccomp.json alpine:3.18 sh -c "echo seccomp ok"
```

**QUICK TESTS**
- Without `NET_BIND_SERVICE`, non-root bind to port 80 should fail:
```bash
docker run --rm --user 1000 python:3.11 python -c "import socket; s=socket.socket(); s.bind(('0.0.0.0',80))"
```
- With `NET_BIND_SERVICE`, it should succeed:
```bash
docker run --rm --user 1000 --cap-add=NET_BIND_SERVICE python:3.11 python -c "import socket; s=socket.socket(); s.bind(('0.0.0.0',80)); print('BOUND')"
```

---

## 3) Docker Content Trust (DCT)

**WHAT**  
Cryptographic signing and verification of container images to ensure image integrity and provenance.

**WHY**  
Prevents running tampered or untrusted images; enforces supply-chain security for image pulls.

**HOW**
- Enable verification at runtime: `export DOCKER_CONTENT_TRUST=1`.
- To publish signed images, configure Notary and manage keys (advanced).

**WHEN**
- Use in production pull pipelines and CI/CD verification.
- Use when third-party registries are involved or when image provenance is critical.

**EXAMPLE**
```bash
export DOCKER_CONTENT_TRUST=1
docker pull alpine:latest   # fails if image is unsigned
```

**QUICK TEST**
- Attempt to pull an unsigned image with `DOCKER_CONTENT_TRUST=1`; it should fail.
- Sign an image and verify with DCT enabled.

---

## 4) Image scanning (Trivy, Anchore)

**WHAT**  
Scan images for vulnerable packages, misconfigurations, and secret leaks.

**WHY**  
Images can contain outdated packages with known CVEs. Scanning finds issues before deployment.

**HOW**
- **Trivy**: local, fast scanner — easiest to integrate.
- **Anchore**: server-based policy engine for CI/CD and audit policies.

**WHEN**
- Always in CI pipeline; run nightly scans for new CVEs; scan during local development too.

**EXAMPLE (Trivy)**
```bash
trivy image nginx:latest
```

**EXAMPLE (Anchore CLI)**
```bash
anchore-cli image add nginx:latest
anchore-cli image vuln nginx:latest all
```

**QUICK TEST**
- Run `trivy image <image>` and inspect HIGH/CRITICAL findings.
- Update base image or packages and re-scan.

---

## 5) Secrets management

**WHAT**  
Securely inject secrets (passwords, API keys) into containers without baking them into images.

**WHY**  
Hardcoding secrets in images or source control leads to leaks. Proper secret management prevents accidental exposure.

**HOW**
- Use Docker Secrets (Swarm) for services.
- Use secret managers (Vault, AWS Secrets Manager, GCP Secret Manager) for production.
- For local dev: use `.env` files but ensure `.gitignore` excludes them.

**WHEN**
- Production: always use a secret manager or Docker Secrets.
- Development: `.env` is acceptable with care (do not commit).

**EXAMPLE (Docker Swarm)**
```bash
docker swarm init
echo "my_db_password" | docker secret create db_password -
docker service create --name myapp --secret db_password nginx:alpine
# inside container: /run/secrets/db_password
```

**QUICK TEST**
- Access `/run/secrets/db_password` inside the container.
- Verify the secret is not present in image layers or `docker history`.

---

## 6) Namespaces & Cgroups basics

**WHAT**
- **Namespaces**: isolate kernel resources (PID, NET, MNT, UTS, IPC) per container.
- **Cgroups**: control groups to limit and monitor resources (CPU, memory, I/O).

**WHY**
- Namespaces provide isolation so containers don’t see each other’s processes or mounts.
- Cgroups enforce resource limits to prevent noisy-neighbor issues.

**HOW**
- Docker creates namespaces automatically.
- Use `--memory` and `--cpus` to set cgroup limits.

**WHEN**
- Always set resource limits for production and multi-tenant hosts.
- Use namespaces knowledge for troubleshooting and advanced isolation.

**EXAMPLE**
```bash
docker run -d --memory=256m --cpus=0.5 nginx:latest
```

**QUICK TEST**
- Run a memory heavy process and observe OOM kill when exceeding the memory limit.
- Use `docker stats` to monitor resource usage.

---

## Quick checklist (pre-deploy)
```
[ ] Dockerfile uses non-root user
[ ] Capabilities: --cap-drop=ALL and only necessary --cap-add
[ ] Seccomp profile applied or default used
[ ] Image scanned with Trivy (CI + nightly)
[ ] Secrets are managed with Docker Secrets / Vault
[ ] Resource limits configured (--memory, --cpus)
[ ] Docker Content Trust enabled for verified pulls (prod)
[ ] Automation: all checks in CI/CD
```

---

## Hands-on scripts included in this package
- `Dockerfile` — non-root demo image
- `custom-seccomp.json` — example seccomp profile
- `test-scripts.sh` — run quick tests (build, capability tests, seccomp test)

---

## Final notes
- Principle: **least privilege** — give only what is necessary.  
- Combine controls: non-root + capabilities + seccomp + secrets + scanning + resource limits.  
- Automate security checks in CI/CD.

<p align="center">
  <img src="https://img.shields.io/badge/Follow-Tech%20With%20Diwana-red?style=for-the-badge"/> <img src="https://img.shields.io/badge/Day--10--Docker--Security-blue?style=for-the-badge"/>
</p>

# Containerisation Playground 🐳

A self-contained learning environment for exploring Docker and containerisation,
running entirely inside a **GitHub Codespace** — no local installation required.

## Getting Started

### 1. Open in a Codespace

Click the green **Code** button on GitHub → **Codespaces** → **Create codespace on main**.

The environment will build automatically. This takes 2–3 minutes the first time
as it pulls Docker base images. Grab a coffee. ☕

### 2. Verify Docker is available

Once your codespace is ready, open a terminal (`Ctrl+`` `) and run:

```bash
docker --version
docker info
```

You should see Docker version information and daemon details. You now have a
fully functional Docker environment inside your codespace.

### 3. Work through the exercises

The exercises are in the `exercises/` directory, numbered in order:

| Exercise | Topic |
|---|---|
| [01 — Getting Started](./exercises/01-getting-started/README.md) | Running your first containers |
| [02 — Building Images](./exercises/02-building-images/README.md) | Writing Dockerfiles |
| [03 — Volumes](./exercises/03-volumes/README.md) | Persisting data |
| [04 — Networking](./exercises/04-networking/README.md) | Container networking |
| [05 — Compose](./exercises/05-compose/README.md) | Multi-container applications |

There are also ready-made sample applications in `samples/` that you can build
and run immediately to see real-world patterns.

---

## What Can You Do Here?

Because Codespaces runs on a full virtual machine, you have access to a genuine
Docker daemon. This means you can:

- ✅ Run containers (`docker run`)
- ✅ Build images from Dockerfiles (`docker build`)
- ✅ Use Docker Compose (`docker compose up`)
- ✅ Inspect networks, volumes, and containers
- ✅ Open containerised web apps in your browser (ports are forwarded automatically)
- ✅ Pull images from Docker Hub
- ✅ Tag and explore image layers

## Quick Reference

```bash
# Run a container interactively
docker run -it alpine sh

# Run a web server and open it in your browser
docker run -d -p 8080:80 nginx:alpine
# → Click "Open in Browser" when the port notification appears

# List running containers
docker ps

# List all containers (including stopped)
docker ps -a

# Stop a container
docker stop <container-id>

# Remove all stopped containers
docker container prune

# List downloaded images
docker images

# Remove an image
docker rmi <image-name>
```

---

## About This Repository

This is a **GitHub template repository**. Use it as the basis for your own
containerisation exercises by clicking **Use this template** on GitHub.

Built for use with GitHub Codespaces and the
[Dev Containers](https://containers.dev/) specification.

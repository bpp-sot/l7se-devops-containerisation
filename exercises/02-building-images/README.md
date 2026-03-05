# Exercise 02 — Building Images with Dockerfiles

## Learning Objectives

- Write a `Dockerfile` from scratch
- Understand common Dockerfile instructions
- Build an image with `docker build`
- Understand image layers and caching

---

## Background

A **Dockerfile** is a plain-text recipe that tells Docker how to build an
image. Each instruction in the file creates a new **layer**. Docker caches
layers, so unchanged layers are reused on subsequent builds — keeping builds
fast.

---

## Tasks

### 1. Examine the Provided Dockerfile

Open `Dockerfile` in this directory. Read through it and understand what each
instruction does before building.

---

### 2. Build the Image

```bash
# From this directory
docker build -t my-web-app:v1 .
```

Watch the output. Notice:
- Each instruction becomes a build step
- Steps with a `CACHED` label were reused from a previous build
- The final image ID is printed at the end

```bash
# List your images
docker images | grep my-web-app
```

---

### 3. Run Your Image

```bash
docker run -d -p 8080:80 --name my-web-app my-web-app:v1
```

Open port 8080 in your browser — you should see the custom page.

---

### 4. Explore Caching

Make a small change to `index.html` (e.g., change the title), then rebuild:

```bash
docker build -t my-web-app:v2 .
```

**Question:** Which layers were cached and which were rebuilt? Why?

---

### 5. Inspect Image Layers

```bash
# See the history of an image (one row per layer)
docker image history my-web-app:v2

# Inspect the image metadata
docker image inspect my-web-app:v2
```

---

### 6. Understanding the Build Context

The `.dockerignore` file controls which files are sent to the Docker daemon
during build (the "build context"). Create a `.dockerignore` file:

```
.git
*.log
node_modules
__pycache__
```

**Question:** Why is it important to keep the build context small?

---

## Dockerfile Instruction Reference

| Instruction | Purpose |
|---|---|
| `FROM` | Base image to build upon |
| `RUN` | Execute a shell command during build |
| `COPY` | Copy files from build context into image |
| `ADD` | Like COPY, but also handles URLs and tar extraction |
| `WORKDIR` | Set the working directory for subsequent instructions |
| `ENV` | Set environment variables |
| `EXPOSE` | Document which port the container listens on |
| `CMD` | Default command to run when the container starts |
| `ENTRYPOINT` | Configure the container as an executable |
| `ARG` | Build-time variable (not available at runtime) |
| `LABEL` | Add metadata to the image |

---

## Best Practices

- **Fewer layers is generally better** — chain `RUN` commands with `&&`
- **Order matters for caching** — put infrequently changed instructions first
- **Use specific base image tags** — `python:3.12-slim` not `python:latest`
- **Run as a non-root user** — add a `USER` instruction
- **Keep images small** — use `-slim` or `alpine` variants, clean up after installs

---

## Challenge

Modify the `Dockerfile` to:
1. Add a `LABEL` with your name and a version number
2. Create and switch to a non-root user before the `CMD`
3. Add a build argument (`ARG`) that lets you customise the page title at build time

---

➡️ **Next:** [Exercise 03 — Volumes](../03-volumes/README.md)

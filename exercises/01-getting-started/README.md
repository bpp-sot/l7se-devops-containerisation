# Exercise 01 — Getting Started with Docker

## Learning Objectives

By the end of this exercise you should be able to:

- Explain what a container is and why it differs from a virtual machine
- Run a container from a public image
- Distinguish between *images* and *containers*
- Use basic `docker` CLI commands

---

## Background

A **container** is an isolated process (or group of processes) that shares
the host operating system's kernel but has its own filesystem, network
interface, and resource limits. Images are read-only templates; containers
are running instances of those images.

Think of it this way:

> Image → Class | Container → Instance

---

## Tasks

### 1. Hello, World

Run the canonical Docker hello-world container:

```bash
docker run hello-world
```

Read the output carefully. Notice that Docker:
1. Looked for the image locally
2. Pulled it from Docker Hub (since it wasn't cached)
3. Created a container from the image
4. Ran the container (which printed a message and exited)

**Question:** What is the difference between `docker run` and `docker start`?

---

### 2. Running an Interactive Shell

Run an Alpine Linux container and get a shell inside it:

```bash
docker run -it alpine sh
```

Inside the container, try:

```sh
# What OS are we on?
cat /etc/os-release

# What processes are running?
ps aux

# What is the hostname?
hostname

# Who are we?
whoami

# Exit the container
exit
```

**Question:** How many processes were visible inside the container? How does
that compare to a virtual machine?

---

### 3. Running a Container in the Background

Run an Nginx web server detached (in the background):

```bash
docker run -d -p 8080:80 --name my-nginx nginx:alpine
```

Flags explained:
- `-d` — detached mode (runs in the background)
- `-p 8080:80` — maps port 8080 on the codespace to port 80 in the container
- `--name my-nginx` — gives the container a memorable name

Now check it's running:

```bash
docker ps
```

GitHub Codespaces will show a notification offering to open port 8080 in your
browser. Click it — you should see the Nginx welcome page.

---

### 4. Inspecting a Container

```bash
# View logs from the running container
docker logs my-nginx

# Stream logs in real time (Ctrl+C to stop)
docker logs -f my-nginx

# Inspect all metadata about the container
docker inspect my-nginx

# View resource usage
docker stats my-nginx --no-stream
```

---

### 5. Stopping and Cleaning Up

```bash
# Stop the container gracefully
docker stop my-nginx

# Remove the stopped container
docker rm my-nginx

# Or do both in one command
docker rm -f my-nginx

# See all containers, including stopped ones
docker ps -a
```

---

## Challenge

1. Run a container from the `ubuntu:24.04` image interactively.
2. Inside the container, install `curl` using `apt-get`.
3. Use `curl` to fetch a web page.
4. Exit the container and start it again with `docker start -ai <container-id>`.
5. Is `curl` still installed? Why, or why not?

---

## Key Commands Summary

| Command | What it does |
|---|---|
| `docker run <image>` | Create and start a container |
| `docker ps` | List running containers |
| `docker ps -a` | List all containers |
| `docker stop <id>` | Stop a container |
| `docker rm <id>` | Remove a stopped container |
| `docker logs <id>` | View container logs |
| `docker inspect <id>` | Detailed container metadata |
| `docker images` | List locally cached images |

---

➡️ **Next:** [Exercise 02 — Building Images](../02-building-images/README.md)

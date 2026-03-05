# Exercise 05 — Docker Compose

## Learning Objectives

- Understand why Compose exists and what problem it solves
- Read and write a `compose.yml` file
- Start, stop, and manage multi-container applications
- Use Compose for local development workflows

---

## Background

Running multi-container applications with individual `docker run` commands
quickly becomes unwieldy. **Docker Compose** lets you define your entire
application stack in a single `compose.yml` file and manage it with simple
commands.

Compose handles:
- Starting containers in dependency order
- Creating shared networks automatically
- Managing volumes
- Environment variable injection

---

## Tasks

### 1. Examine the Compose File

Open `compose.yml` in this directory. Notice:
- Each top-level key under `services` is a container
- Networks and volumes are declared once and referenced by name
- `depends_on` controls start order
- Environment variables are set inline or from a `.env` file

---

### 2. Start the Stack

```bash
# From this directory
docker compose up -d
```

Compose will:
1. Create a dedicated network
2. Start services in dependency order
3. Stream logs until all services are healthy (or detach with `-d`)

```bash
# Check what's running
docker compose ps

# View logs for all services
docker compose logs

# Follow logs for a specific service
docker compose logs -f web
```

Open port 8080 in your browser to see the application.

---

### 3. Scale a Service

```bash
# Run multiple instances of the web service
docker compose up -d --scale web=3

docker compose ps
```

**Question:** What happens when you try to publish port 8080 with three
replicas? How does Nginx handle load balancing?

---

### 4. Run One-Off Commands

```bash
# Run a command in a new container from the web service image
docker compose run --rm web sh

# Execute a command in a running container
docker compose exec db psql -U postgres -c '\l'
```

---

### 5. Manage the Lifecycle

```bash
# Stop all services (containers remain)
docker compose stop

# Start them again
docker compose start

# Stop and remove containers, networks (volumes are kept)
docker compose down

# Stop and remove everything including volumes
docker compose down -v
```

---

### 6. Overriding with Multiple Compose Files

A common pattern is a base `compose.yml` with a `compose.override.yml`
for local development differences:

```bash
# Compose merges these automatically
docker compose -f compose.yml -f compose.override.yml up
```

---

## Compose File Reference

```yaml
services:
  my-service:
    image: nginx:alpine          # Use an existing image
    build: ./path/to/dir         # Or build from a Dockerfile
    ports:
      - "8080:80"
    environment:
      - MY_VAR=value
    env_file:
      - .env
    volumes:
      - ./local-dir:/container-path
      - named-volume:/data
    networks:
      - my-net
    depends_on:
      - other-service
    restart: unless-stopped
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost"]
      interval: 30s
      timeout: 5s
      retries: 3

networks:
  my-net:

volumes:
  named-volume:
```

---

## Challenge

Extend the provided `compose.yml` to add a **Redis** cache service:
1. Add a `cache` service using the `redis:7-alpine` image
2. Ensure it's on the same network as the `web` service
3. Make `web` depend on `cache`
4. Add a volume to persist Redis data

---

➡️ Well done — you've completed all five exercises! 🎉

Explore the `samples/` directory for more realistic application examples.

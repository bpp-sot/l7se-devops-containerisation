# Exercise 03 — Volumes and Data Persistence

## Learning Objectives

- Understand why containers are ephemeral by default
- Use **bind mounts** to share files between host and container
- Use **named volumes** for managed persistent storage
- Know when to use each type

---

## Background

Containers have a writable layer, but it is **destroyed when the container is
removed**. For persistent data (databases, uploaded files, logs), you need
**volumes**.

Docker provides two main mechanisms:

| Type | Description | Best for |
|---|---|---|
| **Bind mount** | Maps a specific host path into the container | Development (live code editing) |
| **Named volume** | Managed by Docker, stored in `/var/lib/docker/volumes/` | Databases, production data |

---

## Tasks

### 1. Demonstrate Ephemeral Storage

```bash
# Create a container, write a file inside it, then exit
docker run --name ephemeral alpine sh -c "echo 'I exist' > /tmp/test.txt && cat /tmp/test.txt"

# Remove the container
docker rm ephemeral

# Try to recover the file — it's gone
docker run --rm alpine ls /tmp/
```

**Question:** When is ephemeral storage actually desirable?

---

### 2. Bind Mounts — Live Editing

Create a local directory and mount it into a container:

```bash
mkdir -p /tmp/my-site

echo "<h1>Hello from the host!</h1>" > /tmp/my-site/index.html

docker run -d \
  --name live-server \
  -p 8080:80 \
  -v /tmp/my-site:/usr/share/nginx/html:ro \
  nginx:alpine
```

Open port 8080 in your browser. Now edit the file on the host:

```bash
echo "<h1>I changed this on the host! 🎉</h1>" > /tmp/my-site/index.html
```

Refresh your browser — the change is reflected immediately without
rebuilding the container.

The `:ro` flag makes the mount **read-only** inside the container.
Remove it if the container needs to write to the directory.

```bash
docker rm -f live-server
```

---

### 3. Named Volumes — Persistent Storage

```bash
# Create a named volume
docker volume create my-data

# List volumes
docker volume ls

# Inspect the volume
docker volume inspect my-data
```

Write data to the volume:

```bash
docker run --rm \
  -v my-data:/data \
  alpine sh -c "echo 'Persisted data' > /data/important.txt"
```

Remove the container (it's already removed with `--rm`), then read the
data back with a new container:

```bash
docker run --rm \
  -v my-data:/data \
  alpine cat /data/important.txt
```

The data persists across container lifecycles.

---

### 4. Real-World Example — PostgreSQL

```bash
docker volume create pg-data

docker run -d \
  --name my-postgres \
  -e POSTGRES_PASSWORD=secret \
  -e POSTGRES_DB=mydb \
  -v pg-data:/var/lib/postgresql/data \
  -p 5432:5432 \
  postgres:16-alpine
```

Stop and remove the container, then start a new one using the same volume:

```bash
docker rm -f my-postgres

docker run -d \
  --name my-postgres-2 \
  -e POSTGRES_PASSWORD=secret \
  -e POSTGRES_DB=mydb \
  -v pg-data:/var/lib/postgresql/data \
  -p 5432:5432 \
  postgres:16-alpine
```

**Question:** Is the `mydb` database still there? How would you verify this?

---

### 5. Cleaning Up

```bash
# Remove a volume (only works if no container is using it)
docker volume rm my-data

# Remove all unused volumes
docker volume prune

# Clean up the postgres container and volume
docker rm -f my-postgres-2
docker volume rm pg-data
```

---

## Challenge

Run a container with a bind mount pointing to the `samples/simple-web/`
directory in this repository. Make a change to `index.html` and verify
the running container serves the updated version.

---

➡️ **Next:** [Exercise 04 — Networking](../04-networking/README.md)

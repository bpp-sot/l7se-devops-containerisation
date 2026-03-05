# Exercise 04 — Container Networking

## Learning Objectives

- Understand Docker's default network drivers
- Create custom bridge networks
- Enable container-to-container communication by name
- Understand why containers on different networks are isolated

---

## Background

Docker creates a virtual network for containers. By default, containers
on the same **user-defined bridge network** can reach each other by name.
Containers on the default `bridge` network can only communicate by IP address
(not name), which is why custom networks are recommended.

---

## Network Drivers

| Driver | Description |
|---|---|
| `bridge` | Default. Isolated virtual network on the host. |
| `host` | Container shares the host's network stack directly. |
| `none` | No networking. Complete isolation. |
| `overlay` | Multi-host networking (used with Docker Swarm). |

---

## Tasks

### 1. Inspect the Default Networks

```bash
docker network ls
docker network inspect bridge
```

Note the subnet, gateway, and any connected containers.

---

### 2. Create a Custom Network

```bash
docker network create my-network

docker network ls
docker network inspect my-network
```

---

### 3. Container-to-Container Communication

Start two containers on the same custom network:

```bash
# Container 1: a simple web server
docker run -d \
  --name web-server \
  --network my-network \
  nginx:alpine

# Container 2: a utility container we'll use to talk to the first
docker run -it \
  --name client \
  --network my-network \
  alpine sh
```

Inside the `client` container, use the **name** of the other container
as its hostname:

```sh
# Ping by container name — this only works on user-defined networks
ping web-server -c 4

# Make an HTTP request to the web server by name
wget -qO- http://web-server

exit
```

---

### 4. Network Isolation

Start a third container on the *default* bridge network (no `--network` flag):

```bash
docker run -it --name isolated alpine sh
```

Inside, try to reach `web-server`:

```sh
ping web-server -c 2    # This will fail — different network
exit
```

**Question:** How would you allow the `isolated` container to communicate
with `web-server`?

```bash
# Connect an existing container to a network
docker network connect my-network isolated
```

Now try again — does it work?

---

### 5. Publishing Ports

Port publishing exposes a container port to the codespace host:

```bash
# -p <host-port>:<container-port>
docker run -d -p 8080:80 --name public-web --network my-network nginx:alpine
```

The Codespace forwards this to your browser automatically. Containers on
`my-network` can still reach `public-web` by name on port 80 — port
publishing only affects host-level access.

---

### 6. Clean Up

```bash
docker rm -f web-server client isolated public-web
docker network rm my-network
```

---

## Challenge

Create two containers on a custom network:
1. A PostgreSQL container (no port published — internal only)
2. An `alpine` container that connects to it using `nc` (netcat) on port 5432

Verify they can communicate, then verify a container on a *different* network
cannot reach the database.

---

➡️ **Next:** [Exercise 05 — Docker Compose](../05-compose/README.md)

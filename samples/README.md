# Samples

Ready-to-run example applications. Each demonstrates a different pattern.

## simple-web

A static HTML site served by Nginx. The simplest possible Dockerfile.

```bash
cd samples/simple-web
docker build -t simple-web .
docker run -d -p 8080:80 simple-web
```

## python-app

A Flask web API using a **multi-stage build** — the final image contains only
the runtime, not the build tools. Compare image sizes:

```bash
cd samples/python-app

# Build the multi-stage image
docker build -t python-app .

# Build a naive single-stage version for comparison
# (uncomment the single-stage Dockerfile if provided)

# Check the size difference
docker images | grep -E "python-app|python"

# Run it
docker run -d -p 5000:5000 python-app
```

Visit `/info` in your browser to see container metadata.

## multi-stage

Demonstrates the size difference between a naïve image and a well-optimised
multi-stage image for a compiled language (or dependency-heavy app).

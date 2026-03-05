#!/usr/bin/env bash
# post-create.sh — runs once after the devcontainer is first built.
# Use this to pull base images so the learner isn't waiting on first use.

set -euo pipefail

echo ""
echo "==================================================="
echo "  Setting up your Containerisation Playground  🐳"
echo "==================================================="
echo ""

echo "→ Pulling common base images (this saves time in the exercises)..."
docker pull hello-world        2>/dev/null && echo "  ✓ hello-world"
docker pull alpine:latest      2>/dev/null && echo "  ✓ alpine"
docker pull nginx:alpine       2>/dev/null && echo "  ✓ nginx:alpine"
docker pull python:3.12-slim   2>/dev/null && echo "  ✓ python:3.12-slim"
docker pull node:20-alpine     2>/dev/null && echo "  ✓ node:20-alpine"

echo ""
echo "→ Verifying Docker installation..."
docker --version
docker compose version

echo ""
echo "==================================================="
echo "  All done! Open README.md to get started.  🚀"
echo "==================================================="
echo ""

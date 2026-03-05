# ─── Multi-stage build example ────────────────────────────────────────────────
#
# Stage 1: "builder" — installs dependencies into a virtual environment.
#           This stage has build tools and pip; we don't want these in prod.
#
FROM python:3.12-slim AS builder

WORKDIR /app

# Install dependencies into an isolated virtual environment
COPY requirements.txt .
RUN python -m venv /app/venv \
    && /app/venv/bin/pip install --no-cache-dir -r requirements.txt


# ─── Stage 2: "runtime" — the final, minimal production image ─────────────────
#
# We start fresh from the same slim base and copy only what we need from builder.
# No pip, no compiler, no build cruft.
#
FROM python:3.12-slim AS runtime

# Create a non-root user for security
RUN useradd --create-home appuser
WORKDIR /home/appuser

# Copy the virtual environment from the builder stage
COPY --from=builder /app/venv /app/venv

# Copy application code
COPY app.py .

# Run as non-root
USER appuser

EXPOSE 5000

ENV PATH="/app/venv/bin:$PATH"
ENV FLASK_APP=app.py

CMD ["python", "app.py"]

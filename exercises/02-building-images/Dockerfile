# ─── Stage: Build our custom Nginx site ───────────────────────────────────────
# Every Dockerfile must start with a FROM instruction.
# We're using the official Nginx image based on Alpine Linux — it's tiny (~7 MB).
FROM nginx:alpine

# Add metadata labels (good practice)
LABEL maintainer="your-name@example.com"
LABEL description="A simple containerised website for learning"
LABEL version="1.0"

# Remove the default Nginx welcome page
RUN rm -rf /usr/share/nginx/html/*

# Copy our custom web content into the image.
# COPY <src-in-build-context> <dest-in-image>
COPY index.html /usr/share/nginx/html/index.html
COPY style.css  /usr/share/nginx/html/style.css

# Document the port this container will listen on.
# This is informational only — it doesn't actually publish the port.
# You still need -p when running the container.
EXPOSE 80

# CMD defines the default command to run when the container starts.
# Using JSON array form ("exec form") is preferred — avoids shell overhead.
CMD ["nginx", "-g", "daemon off;"]

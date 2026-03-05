FROM nginx:alpine

LABEL description="Sample: simple static website"

COPY index.html /usr/share/nginx/html/index.html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

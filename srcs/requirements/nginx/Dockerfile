# Use the penultimate stable version of Alpine
FROM alpine:3.19

# Install NGINX and OpenSSL
RUN apk update && apk add --no-cache\
    nginx \
    openssl

# Copy the NGINX configuration
# Generate self-signed certificate for TLS
RUN mkdir -p /etc/nginx/ssl
RUN openssl req -x509 -nodes \
     -keyout /etc/nginx/ssl/nginx.key \
     -out /etc/nginx/ssl/nginx.crt \
     -subj "/C=DE/ST=Berlin/L=Berlin/O=42/CN=login.42.fr/UID=login"

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# Expose port 443 for HTTPS
EXPOSE 443

# Command to run NGINX
CMD ["nginx", "-g", "daemon off;"]

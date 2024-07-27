# requirements/wordpress/Dockerfile
FROM alpine:3.19

RUN apk update && apk add --no-cache php php-fpm php-mysqli
# Add additional PHP and WordPress dependencies here

# Ensure the php-fpm service is running
CMD ["/usr/sbin/php-fpm8.1", "-F"]

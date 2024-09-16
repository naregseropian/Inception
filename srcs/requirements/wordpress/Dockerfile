# Use the Alpine Linux base image
FROM alpine:3.19

# Install MariaDB and necessary dependencies
RUN adduser -S -G www-data www-data \
    && mkdir -p /var/www/html /var/log/php81 \
    && chown -R www-data:www-data /var/www/html /var/log/php81 \
	&& chmod -R 775 /var/www/html \
    && apk update \
    && apk add curl ca-certificates ghostscript imagemagick php81 fcgi \
	&& apk add php81-fpm php81-mysqli php81-phar php81-mbstring php81-cgi \
	php81-common php81-session php81-iconv php81-json php81-gd php81-curl \
	php81-xml php81-imap php81-pdo php81-pdo_mysql php81-soap php81-posix \
	php81-gettext php81-ldap php81-ctype php81-dom php81-simplexml php81-zip \
	php81-tokenizer php81-redis
RUN ln -sf /usr/bin/php81 /usr/bin/php

COPY /conf/www.conf /etc/php81/php-fpm.d/www.conf

RUN chown www-data:www-data /etc/php81/php-fpm.d/www.conf

WORKDIR /usr/local/bin
RUN curl -o wp \
	https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp
COPY tools/wordpress-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/wordpress-entrypoint.sh

WORKDIR /var/www/html
USER www-data
ENTRYPOINT [ "wordpress-entrypoint.sh" ]
EXPOSE 9000
CMD [ "php-fpm81", "-F" ]
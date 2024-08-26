# Use the Alpine Linux base image
FROM alpine:3.19

# Install MariaDB and necessary dependencies
RUN apk update && \
    apk add --no-cache wget \
    bash curl mariadb-client icu-data-full ghostscript \
    imagemagick openssl php82 php82-fpm php82-phar php82-json php82-mysqli \
    php82-curl php82-dom php82-exif php82-fileinfo php82-pecl-igbinary \
    php82-pecl-imagick php82-intl php82-mbstring php82-openssl \
    php82-xml php82-zip php82-iconv php82-shmop php82-simplexml php82-sodium \
    php82-xmlreader php82-zlib php82-tokenizer

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp
RUN mkdir -p /var/www/html
RUN cd /var/www/html && wp core download --allow-root || true

# Download and extract WordPress
RUN wget https://wordpress.org/latest.tar.gz \
    && tar -xzf latest.tar.gz \
    # && cp -r wordpress/* /var/www/html/ \
    && rm -rf wordpress latest.tar.gz

# Set permissions
# RUN chown -R www-data:www-data /var/www/html

RUN mkdir -p  /var/www/html/

RUN chmod 777 /var/www/html/

COPY ./conf/php.conf /etc/php82/php-fpm.d/www.conf

COPY tools/wordpress-entrypoint.sh /usr/local/bin/

EXPOSE 9000

ENTRYPOINT [ "bash", "/usr/local/bin/wordpress-entrypoint.sh" ]
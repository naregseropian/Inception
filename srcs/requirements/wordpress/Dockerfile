FROM wordpress:latest

# Configure WordPress
COPY ./conf/wp-config.php /var/www/html/wp-config.php

# Expose port 9000 for PHP-FPM
EXPOSE 9000

CMD ["php-fpm"]
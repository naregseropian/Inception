#!bin/bash
cd /var/www/html

# healthycheck
until mysqladmin ping --host=mariadb:3306 --silent; do
    echo "Waiting for MariaDB to start..."
    sleep 2
done

if [ ! -f wp-config.php ]; then
    wp config create	--allow-root --dbname=$SQL_DATABASE --dbuser=$SQL_USER --dbpass=$SQL_ROOT_PASSWORD \
    					--dbhost=mariadb:/var/run/mysqld/mysqld.sock --allow-root

sleep 2
wp core install     --url=$DOMAIN_NAME --title=$SITE_TITLE --admin_user=$ADMIN_USER --admin_password=$ADMIN_PASSWORD --admin_email=$ADMIN_EMAIL --allow-root --path='/var/www/wordpress'
wp user create      --allow-root --role=author $USER1_LOGIN $USER1_MAIL --user_pass=$USER1_PASS --allow-root >> /log.txt
fi

exec /usr/sbin/php-fpm82 -F
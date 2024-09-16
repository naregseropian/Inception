#!/bin/sh

if [ ! -f wp-config-sample.php ]; then
	wp core download --skip-content
fi

if [ ! -f wp-config.php ]; then
    wp config create \
    --dbname=${SQL_DATABASE} \
    --dbuser=${SQL_USER} \
    --dbhost="mariadb:3306"
    # --dbpass=${SQL_PASSWORD} \
    # --prompt=dbpass < /run/secrets/wp_db_password

	wp core install --url=${DOMAIN_NAME} --title="${SITE_TITLE}" \
        --url=nseropia.42.fr \
		--admin_user="${ADMIN_USER}" \
        --admin_password="${ADMIN_PASSWORD}" \
		--admin_email="${ADMIN_EMAIL}" --skip-email
	wp user create "${USER1_LOGIN}" "${USER1_MAIL}" --user_pass="${USER1_PASS}" --role="editor"		# --prompt=user_pass < /run/secrets/wp_user_password

	wp theme install ${WP_THEME:=twentytwentythree} --activate --allow-root
fi

exec "$@"
#!/bin/sh

if [ ! -f "/tmp/init.sql" ]; then

    # Check if the database exists
    if ! mariadb --user=root --password="$SQL_ROOT_PASSWORD" -e "USE $SQL_DATABASE;" 2>/dev/null; then
        # If the database does not exist, create the init.sql file with instructions to set up the database
        cat << EOF > /tmp/init.sql
CREATE DATABASE IF NOT EXISTS $SQL_DATABASE;
CREATE USER IF NOT EXISTS '$SQL_USER'@'%' IDENTIFIED BY '$SQL_PASSWORD';
GRANT ALL PRIVILEGES ON $SQL_DATABASE.* TO '$SQL_USER'@'%';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$SQL_ROOT_PASSWORD';
FLUSH PRIVILEGES;
EOF
    else
        mariadb shutdown
        echo "FLUSH PRIVILEGES;" > /tmp/init.sql
    fi
fi

# Execute the passed commands
exec "$@"


# if [ -z "$(ls -A /var/lib/mysql)" ]; then
#     mysql_install_db --datadir="/var/lib/mysql"
# else
#     echo "Database already exists, skipping mysql_install_db."
# fi

# mariadbd & MARIADB_PID=$!

# for i in {30..0}; do
# 	if mariadb -e "SELECT '1';" &> /dev/null; then
# 		echo 'mariadb init started'
# 		break
# 	fi
# 	echo 'mariadb init starting...'
# 	sleep 1
# done

# if [ "$i" = 0 ]; then
# 	echo >&2 'mariadb init failed'
# 	exit 1
# fi

# # More secure installation, and to avoid anonymous user interfering with WP user on healthcheck
# mariadb -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('${SQL_ROOT_PASSWORD}');"
# mariadb -e "DELETE FROM mysql.user WHERE User='';"
# mariadb -e "DROP DATABASE IF EXISTS test;"
# mariadb -e "DELETE FROM mysql.db where Db='test' OR Db='test\\_%'"
# mariadb -e "FLUSH PRIVILEGES;"

# # Wp database and user init
# mariadb -e "CREATE DATABASE IF NOT EXISTS ${SQL_DATABASE};"
# mariadb -e "CREATE USER IF NOT EXISTS '${ADMIN_USER}'@'%' IDENTIFIED BY '${ADMIN_PASSWORD}';"
# mariadb -e "GRANT ALL ON ${SQL_DATABASE}.* TO '${ADMIN_USER}'@'%' WITH GRANT OPTION; FLUSH PRIVILEGES;"

# kill -s TERM "$MARIADB_PID"

# wait "$MARIADB_PID"

# exec mariadbd-safe
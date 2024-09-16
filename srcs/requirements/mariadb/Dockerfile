# Use the Alpine Linux base image
FROM alpine:3.19

# Install MariaDB and necessary dependencies
RUN apk update \
    && apk add mariadb mariadb-client \
    && mkdir -p /var/lib/mysql /var/run/mysqld \
	&& chown -R mysql:mysql /var/lib/mysql /var/run/mysqld \
	&& chmod 777 /var/run/mysqld \
	&& mariadb-install-db --user=mysql --datadir=/var/lib/mysql --skip-test-db --skip-grant-tables

COPY ./conf/mariadb.conf /etc/my.cnf
COPY tools/auto_config.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/auto_config.sh

USER mysql

ENTRYPOINT [ "auto_config.sh" ]
EXPOSE 3306
CMD [ "mariadbd", "--no-defaults", "--datadir=/var/lib/mysql", \
	"--bind-address=*", "--init-file=/tmp/init.sql", "--skip-grant-tables" ]
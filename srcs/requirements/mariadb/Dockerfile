# Use the Alpine Linux base image
FROM alpine:3.19

# Install MariaDB and necessary dependencies
RUN apk update
RUN apk add --no-cache \
    mariadb \
    mariadb-client \
    mysql \
    mysql-client \
    bash \
    sudo

# Ensure the data directory exists
RUN mkdir -p /var/lib/mysql /run/mysqld /var/run/mysqld && \
    chown -R mysql:mysql /var/lib/mysql /run/mysqld /var/run/mysqld /etc/my.cnf.d && \
    chmod -R 750 /var/lib/mysql /run/mysqld /var/run/mysqld

# Initialize the MariaDB database
RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

COPY ./conf/mariadb.conf /etc/my.cnf.d/mariadb-server.cnf

# Expose the MariaDB port
EXPOSE 3306


COPY tools/auto_config.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/auto_config.sh

USER mysql

ENTRYPOINT [ "bash", "auto_config.sh" ]

# Command to run MariaDB server
# CMD ["mysqld", "--user=mysql" , "--datadir=/var/lib/mysql"]
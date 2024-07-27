# srcs/requirements/mariadb/Dockerfile

FROM mariadb:latest

# Environment variables for MariaDB
ENV MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
ENV MYSQL_DATABASE=${MYSQL_DATABASE}
ENV MYSQL_USER=${MYSQL_USER}
ENV MYSQL_PASSWORD=${MYSQL_PASSWORD}

# Copy custom MariaDB configuration
COPY ./conf/my.cnf /etc/mysql/my.cnf

# Expose port 3306 for MariaDB
EXPOSE 3306

CMD ["mysqld"]

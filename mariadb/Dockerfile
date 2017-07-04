FROM mariadb:latest

# default mysql deploy user information! i recommand do not change
# linked my laravel .env file!
# this is optional. if you what change default user
# change this name and change laravel .env file
ENV MYSQL_USER=deployer
ENV MYSQL_PASSWORD=secret
ENV MYSQL_DATABASE=PixelDB

# this is super secret information.
# if provisioning mysql server.
# change this password difiicult password
ENV MYSQL_ROOT_PASSWORD=secret

# Define working directory.
WORKDIR /data

# Define default command.

# Expose ports.
EXPOSE 3306

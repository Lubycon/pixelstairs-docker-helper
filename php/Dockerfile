FROM ubuntu:16.04
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get clean && \
    apt-get update && \
    apt-get install -y --no-install-recommends apt-utils locales && \
    locale-gen en_US.UTF-8 && update-locale
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
RUN apt-get -y upgrade && apt-get update --fix-missing

RUN apt-get -y install \
        php7.0-fpm \
        php7.0-dev \
        mcrypt \
        php7.0-mcrypt \
        php7.0-mbstring \
        composer \
        php7.0-gd \
        php7.0-pdo \
        php7.0-mysqlnd \
        php7.0-mysql \
        php7.0-curl \
        php7.0-tokenizer \
        php7.0-iconv

RUN sed -i "s/display_errors = Off/display_errors = On/" /etc/php/7.0/fpm/php.ini && \
    sed -i "s/upload_max_filesize = .*/upload_max_filesize = 10M/" /etc/php/7.0/fpm/php.ini && \
    sed -i "s/post_max_size = .*/post_max_size = 12M/" /etc/php/7.0/fpm/php.ini && \
    sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php/7.0/fpm/php.ini && \
    sed -i -e "s/pid =.*/pid = \/var\/run\/php7.0-fpm.pid/" /etc/php/7.0/fpm/php-fpm.conf && \
    sed -i -e "s/error_log =.*/error_log = \/proc\/self\/fd\/2/" /etc/php/7.0/fpm/php-fpm.conf && \
    sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php/7.0/fpm/php-fpm.conf && \
    sed -i "s/listen = .*/listen = 9000/" /etc/php/7.0/fpm/pool.d/www.conf && \
    sed -i "s/;catch_workers_output = .*/catch_workers_output = yes/" /etc/php/7.0/fpm/pool.d/www.conf


# Make ssh dir
RUN mkdir /root/.ssh/

# Copy over private key, and set permissions
ADD id_rsa /root/.ssh/id_rsa

# Create known_hosts
RUN touch /root/.ssh/known_hosts
# Add bitbuckets key
RUN ssh-keyscan bitbucket.org >> /root/.ssh/known_hosts

# Clone the conf files into the docker container
RUN git clone git@bitbucket.org:lubycon/pixelstairs-web-app-api.git


WORKDIR /var/www
EXPOSE 9000
CMD ["php-fpm7.0"]

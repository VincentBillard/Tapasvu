FROM centos:7

# Install Apache 2.4 httpd
RUN yum -y --setopt=tsflags=nodocs update && \
    yum -y --setopt=tsflags=nodocs install httpd && \
    yum clean all

# Install required repos, update and PHP-FPM with usefull modules
RUN yum -y --setopt=tsflags=nodocs update && \
    yum -y --setopt=tsflags=nodocs --nogpgcheck install epel-release && \
    yum -y --setopt=tsflags=nodocs --nogpgcheck install https://centos7.iuscommunity.org/ius-release.rpm && \
    yum -y --setopt=tsflags=nodocs --nogpgcheck install wget && \
    yum -y --setopt=tsflags=nodocs --nogpgcheck install php71u-cli \
        php71u-fpm \
        php71u-bcmath \
        php71u-gd \
        php71u-intl \
        php71u-json \
        php71u-ldap  \
        php71u-mbstring \
        php71u-mcrypt \
        php71u-opcache \
        php71u-pdo \
        php71u-pear  \
        php71u-pecl-apcu \
        php71u-pecl-imagick \
        php71u-pecl-redis \
        php71u-pecl-xdebug  \
        php71u-pgsql \
        php71u-mysqlnd \
        php71u-soap \
        php71u-tidy \
        php71u-xml \
        php71u-xmlrpc && \
        yum clean all

RUN rm /etc/php-fpm.d/www.conf
ADD php-fpm/conf/pool.conf /etc/php-fpm.d/

# Install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && php -r "unlink('composer-setup.php');"

# Install nodejs & npm
RUN wget http://nodejs.org/dist/v10.4.0/node-v10.4.0-linux-x64.tar.gz \
    && tar --strip-components 1 -xzvf node-v10.4.0-linux-x64.tar.gz -C /usr/ \
    && node --version \
    && npm --version

# Add some usefull alias
RUN echo 'alias ll="ls -l"' >> ~/.bashrc && \
    echo 'alias sf="php bin/console"' >> ~/.bashrc

EXPOSE 80

WORKDIR /var/www/html

# Simple startup script to avoid some issues observed with container restart
ADD run.sh /run.sh
RUN chmod -v +x /run.sh

CMD ["/run.sh"]

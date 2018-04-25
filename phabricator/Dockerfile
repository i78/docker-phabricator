FROM ubuntu:artful
MAINTAINER Manfred Dreese <com@dreese.de>

# Install packages
RUN apt-get update

# Register PPAs
RUN apt-get install -y software-properties-common language-pack-en-base && \
    export LANG=en_US.UTF-8 && \
    export LC_ALL=en_US.UTF-8 && \
    add-apt-repository ppa:ondrej/php && \
    apt-get update

# Install dependencies
RUN apt-get install -y python-pygments sendmail imagemagick git sudo \
    mysql-common mysql-client apache2 dpkg-dev  \
    nginx php7.2 php7.2-fpm php7.2-mysql php7.2-gd php7.2-dev \
    php7.2-curl php7.2-cli php7.2-json php7.2-opcache \
    php7.2-mbstring php7.2-mysql python3-pygments php7.2-apcu

# Install phabricator
RUN mkdir --parent /opt/phabricator/app && \
    mkdir --parent /var/log/phabricator && \
    cd /opt/phabricator/app && \
    git clone https://github.com/phacility/libphutil.git && \
    git clone https://github.com/phacility/arcanist.git && \
    git clone https://github.com/phacility/phabricator.git

# Add Configuration
RUN rm /etc/php/7.2/fpm/pool.d/www.conf
COPY files/etc/nginx/sites-available/default /etc/nginx/sites-available/default
COPY files/etc/php/7.2/fpm/pool.d/phabricator.conf /etc/php/7.2/fpm/pool.d/phabricator.conf
ADD files/scripts /scripts

# Set Phabricator config
RUN cd /opt/phabricator/app/phabricator && \
  ./bin/config set mysql.host db && \
  ./bin/config set mysql.port 3306 && \
  ./bin/config set mysql.user root && \
  ./bin/config set mysql.pass phabricator && \
  ./bin/config set pygments.enabled true && \
  ./bin/config set phd.user phd && \
  ./bin/config set diffusion.allow-http-auth true && \
  ./bin/config set environment.append-paths '["/usr/lib/git-core"]'

## create environment
RUN useradd phd --home /home/phd --shell /bin/false && \
    mkdir /tmp/phabricator && \
    mkdir /tmp/phabricator-sessions && \
    mkdir /var/repo && \
    chown -R phd.phd /var/repo && \
    echo "www-data ALL=(phd) SETENV: NOPASSWD: /usr/lib/git-core/git-http-backend" > /etc/sudoers.d/phabricator && \
    echo "opcache.validate_timestamps = 0"  >> /etc/php/7.2/fpm/php.ini


EXPOSE 80
ENTRYPOINT /scripts/start.sh

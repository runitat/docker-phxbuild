FROM node:9
MAINTAINER Manuel Klemenz <manuel.klemenz@runit.at>
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
        && apt-get install -y --no-install-recommends \
            cadaver \
            php5 \
            php5-ldap \
            zip \
            unzip \
            wget \
            curl \
            sqlite3 \
            libfontconfig \
            libfontconfig-dev \
        && rm -rf /var/lib/apt/lists/* \
        && npm set progress=false \
        && npm install --unsafe-perm -g \
            grunt \
            grunt-cli \
            bower \
            gulp \
            phantomjs@1.* \
            @vue/cli \
        && php -r "readfile('https://getcomposer.org/installer');" > composer-setup.php \
        && php composer-setup.php \
        && php -r "unlink('composer-setup.php');" \
        && mv composer.phar /usr/local/bin/composer
RUN useradd -ms /bin/bash builduser

USER builduser
WORKDIR /home/builduser

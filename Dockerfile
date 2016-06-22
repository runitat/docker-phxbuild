FROM node:4
MAINTAINER Manuel Klemenz <manuel.klemenz@runit.at>
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
		&& apt-get install -y --no-install-recommends \
			php5 \
            php5-ldap \
		&& rm -rf /var/lib/apt/lists/* \
        && npm set progress=false \
		&& npm install -g \
            grunt \
            grunt-cli \
            bower \
            gulp \
		&& php -r "readfile('https://getcomposer.org/installer');" > composer-setup.php \
		&& php composer-setup.php \
		&& php -r "unlink('composer-setup.php');" \
		&& mv composer.phar /usr/local/bin/composer
RUN useradd -ms /bin/bash builduser

USER builduser
WORKDIR /home/builduser

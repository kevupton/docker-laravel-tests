FROM ubuntu:trusty

RUN apt-get update -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install libssl-dev swig python-dev curl git -y

RUN apt-get update && \
  apt-get -y install supervisor git apache2 libapache2-mod-php5 mysql-server php5-mysql pwgen php-apc php5-mcrypt && \
  apt-get -qq -y install curl && \
  curl -sS https://getcomposer.org/installer | php && \
  mv composer.phar /usr/local/bin/composer && \
  echo "ServerName localhost" >> /etc/apache2/apache2.conf


ADD . /project

WORKDIR /project

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
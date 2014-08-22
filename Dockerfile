FROM debian:wheezy
MAINTAINER Jose Miguel de la Casa <nacicansao@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN echo "root:Changeme" | chpasswd

# install ssh and supervisord
RUN apt-get update
RUN apt-get install -y curl ssh supervisor apt-utils
RUN mkdir /var/run/sshd
RUN chown root:root /var/run/sshd
RUN mkdir /var/log/supervisord

# install mysql

RUN apt-get install -y mysql-server mysql-client

# install apache2 and php

RUN apt-get install -y php5 libapache2-mod-php5 apache2 libapache2-mod-auth-mysql php5-mysql
RUN apt-get install -y php5-mysql php5-curl php5-gd php5-idn php-pear php5-imagick php5-imap php5-mcrypt php5-memcache php5-mhash php5-ming php5-ps php5-pspell php5-recode php5-snmp php5-sqlite php5-tidy php5-xmlrpc php5-xsl php5-json
 
# install phpmyadmin

RUN apt-get install -y phpmyadmin
RUN echo "\$cfg['Servers'][\$i]['AllowNoPassword'] = TRUE;" >> /etc/phpmyadmin/config.inc.php
RUN cp /etc/phpmyadmin/apache.conf /etc/apache2/sites-enabled/001-phpmyadmin

RUN a2enmod rewrite

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf


# eye2 installation

RUN apt-get -y install wget
RUN apt-get -y install python
RUN apt-get -y install zip unzip exif
RUN apt-get -y install openoffice.org
RUN apt-get -y install libimage-exiftool-perl

#mysql
#RUN /etc/init.d/mysql start ; echo "CREATE USER 'eyeos'@'localhost' IDENTIFIED BY 'password';" | mysql
#RUN /etc/init.d/mysql start ; echo "CREATE DATABASE eyeos;" | mysql
#RUN /etc/init.d/mysql start ; echo "GRANT ALL PRIVILEGES ON eyeos.* TO 'eyeos'@'localhost';" | mysql
#RUN /etc/init.d/mysql start ;echo "FLUSH PRIVILEGES;" | mysql
#RUN /etc/init.d/mysql stop



EXPOSE 22 3306 9001 80

#ENTRYPOINT
CMD ["/usr/bin/supervisord"]



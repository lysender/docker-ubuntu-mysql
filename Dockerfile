FROM ubuntu:wily
MAINTAINER Leonel Baer <leonel@lysender.com>

# Install packages
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
    apt-get -y install mysql-server \
    supervisor && apt-get clean

ADD ./start.sh /start.sh
ADD ./config_mysql.sh /config_mysql.sh
ADD ./config_root_account.sh /config_root_account.sh
ADD ./config_credentials.sh /config_credentials.sh
RUN chmod 755 /*.sh

RUN mkdir -p /etc/supervisor/conf.d
ADD ./supervisor-mysql.conf /etc/supervisor/conf.d/mysql.conf

VOLUME ["/var/lib/mysql", "/var/log/mysql"]

EXPOSE 3306

CMD ["/bin/bash", "/start.sh"]


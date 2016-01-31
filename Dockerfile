FROM ubuntu:wily
MAINTAINER Leonel Baer <leonel@lysender.com>

# Install packages
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
    apt-get -y install mariadb-server \
    supervisor && apt-get clean

ADD ./start.sh /start.sh
ADD ./config_mariadb.sh /config_mariadb.sh
ADD ./config_root_account.sh /config_root_account.sh
ADD ./config_credentials.sh /config_credentials.sh
RUN chmod 755 /*.sh

RUN mkdir -p /etc/supervisor/conf.d
ADD ./supervisor-mariadb.conf /etc/supervisor/conf.d/mariadb.conf

VOLUME ["/var/lib/mysql", "/var/log/mariadb"]

EXPOSE 3306

CMD ["/bin/bash", "/start.sh"]


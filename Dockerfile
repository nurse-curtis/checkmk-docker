FROM phusion/baseimage

MAINTAINER alibby@xforty.com

RUN DEBIAN_FRONTEND=noninteractive apt-get -qq update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -qqy telnet nagios-plugins check-mk-agent xinetd docker.io python python-docker
RUN sed -i 's/^[[:space:]]\{,1\}disable[[:space:]]\{1,\}= yes/        disable        = no/' /etc/xinetd.d/check_mk

COPY plugins /usr/lib/check_mk_agent/plugins
COPY checks /usr/bin
COPY runit /etc/service
RUN chmod +x /usr/bin/check_mk_agent

EXPOSE 6556

CMD /sbin/my_init


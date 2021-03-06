FROM phusion/baseimage:0.9.22

MAINTAINER alibby@xforty.com

RUN DEBIAN_FRONTEND=noninteractive apt-get -qq update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -qqy telnet nagios-plugins xinetd python3.5 python3-pip
# RUN sed -i 's/^[[:space:]]\{,1\}disable[[:space:]]\{1,\}= yes/        disable        = no/' /etc/xinetd.d/check_mk

COPY plugins /usr/lib/check_mk_agent/plugins
COPY checks /usr/bin
COPY runit /etc/service
COPY check_mk /etc/check_mk
COPY agent /tmp

RUN dpkg -i /tmp/check-mk-agent_1.5.0b3-1_all.deb
RUN chmod +x /usr/lib/check_mk_agent/plugins/*
RUN pip3 install check_docker docker
RUN apt-get remove -y python3-pip
RUN apt-get autoremove -y
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN rm /usr/bin/python && ln -s /usr/bin/python3 /usr/bin/python

EXPOSE 6556

CMD /sbin/my_init


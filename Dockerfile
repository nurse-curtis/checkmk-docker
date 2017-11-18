FROM phusion/baseimage:0.9.22

MAINTAINER alibby@xforty.com

RUN DEBIAN_FRONTEND=noninteractive apt-get -qq update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -qqy telnet nagios-plugins check-mk-agent xinetd docker.io python python-pip python-docker
RUN sed -i 's/^[[:space:]]\{,1\}disable[[:space:]]\{1,\}= yes/        disable        = no/' /etc/xinetd.d/check_mk

COPY plugins /usr/lib/check_mk_agent/plugins
COPY checks /usr/bin
COPY runit /etc/service
RUN /bin/chmod +x /usr/bin/check_mk_agent
RUN /bin/chmod +x /usr/lib/check_mk_agent/plugins/check_docker
RUN /usr/bin/pip install docker
RUN apt-get remove -y python-pip
RUN apt-get autoremove -y
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 6556

CMD /sbin/my_init


FROM debian:buster AS wine
MAINTAINER Gerolf Ziegenhain <gerolf.ziegenhain@gmail.com>

# Install Wine, XFCE, network audio stuff
ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
RUN dpkg --add-architecture i386
RUN apt-get update && apt-get -y install xvfb x11vnc xdotool wget tar supervisor net-tools gnupg2 procps
RUN apt-get update && apt-get -y install libgnutls30:i386 libldap-2.4-2:i386 libgpg-error0:i386 libxml2:i386 libasound2-plugins:i386 libsdl2-2.0-0:i386 libfreetype6:i386 libdbus-1-3:i386 libsqlite3-0:i386 xfce4 socat pulseaudio pavucontrol
RUN apt-get -qqy autoclean && rm -rf /tmp/* /var/tmp/*
ENV DISPLAY :0


FROM wine AS novnc
ENV V_NOVNC 1.1.0
ENV V_WEBSOCKIFY 0.9.0
# Install noVNC stuff
WORKDIR /root/
RUN wget -O - https://github.com/novnc/noVNC/archive/v${V_NOVNC}.tar.gz | tar -xzv -C /root/ && mv /root/noVNC-${V_NOVNC} /root/novnc && ln -s /root/novnc/vnc_lite.html /root/novnc/index.html
RUN wget -O - https://github.com/novnc/websockify/archive/v${V_WEBSOCKIFY}.tar.gz | tar -xzv -C /root/ && mv /root/websockify-${V_WEBSOCKIFY} /root/novnc/utils/websockify
# Configure window title
RUN cat /root/novnc/vnc_lite.html | sed 's/<title>noVNC/<title>WineNoVNC/g' > /root/novnc/tmp.html && cat /root/novnc/tmp.html > /root/novnc/vnc_lite.html && rm /root/novnc/tmp.html

RUN apt-get -y install wsjtx

ADD ./config/xfce4 /root/.config/xfce4
# Add startup stuff
ADD ./config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf


EXPOSE 8080
CMD ["/usr/bin/supervisord"]


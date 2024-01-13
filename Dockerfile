FROM debian:latest AS wine

# Install Wine & XFCE & WSJTX
ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
RUN apt-get update && apt-get -y install python3-pip wsjtx xfce4 xvfb x11vnc xdotool wget tar supervisor net-tools gnupg2 procps
RUN apt-get -qqy autoclean && rm -rf /tmp/* /var/tmp/*
ENV DISPLAY :0


FROM wine AS novnc
# ENV V_NOVNC 1.1.0
# ENV V_WEBSOCKIFY 0.9.0
# # Install noVNC stuff
# WORKDIR /root/
# RUN wget -O - https://github.com/novnc/noVNC/archive/v${V_NOVNC}.tar.gz | tar -xzv -C /root/ && mv /root/noVNC-${V_NOVNC} /root/novnc && ln -s /root/novnc/vnc_lite.html /root/novnc/index.html
# RUN wget -O - https://github.com/novnc/websockify/archive/v${V_WEBSOCKIFY}.tar.gz | tar -xzv -C /root/ && mv /root/websockify-${V_WEBSOCKIFY} /root/novnc/utils/websockify
# # Configure window title
# RUN cat /root/novnc/vnc_lite.html | sed 's/<title>noVNC/<title>WineNoVNC/g' > /root/novnc/tmp.html && cat /root/novnc/tmp.html > /root/novnc/vnc_lite.html && rm /root/novnc/tmp.html
RUN apt-get -y install novnc python3-websockify
#RUN openssl req -x509 -nodes -newkey rsa:3072 -keyout novnc.pem -out novnc.pem -days 3650

# Install UDP service client
# RUN git clone https://github.com/8cH9azbsFifZ/py_wsjtx.git
# RUN cd py_wsjtx && pip3 install -r requirements.txt
#RUN apt-get -y install mqtt python3-paho-mqtt

ADD ./config/xfce4 /root/.config/xfce4
ADD ./config/WSJT-X.ini /root/.config/
# Add startup stuff
ADD ./config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf


EXPOSE 8080
EXPOSE 2237

RUN apt-get -y install tigervnc-standalone-server
RUN apt-get -y install dbus-x11
RUN mkdir /root/.vnc 
RUN echo geheim | vncpasswd -f > /root/.vnc/passwd
RUN chmod 0600 /root/.vnc/passwd

COPY entrypoint.sh .

#CMD ["/usr/bin/supervisord"]
CMD ["./entrypoint.sh"]


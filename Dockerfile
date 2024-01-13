FROM debian:latest AS wine

# Install Wine & XFCE & WSJTX
ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
RUN apt-get update && apt-get -y install gettext-base tigervnc-standalone-server dbus-x11 novnc python3-websockify python3-pip wsjtx xfce4 xdotool wget tar net-tools gnupg2 procps
RUN apt-get -qqy autoclean && rm -rf /tmp/* /var/tmp/*
ENV DISPLAY :0

# Set VNC password
RUN mkdir /root/.vnc 
RUN echo "" | vncpasswd -f > /root/.vnc/passwd
RUN chmod 0600 /root/.vnc/passwd
#RUN printf "password\npassword\n\n" | vncpasswd

FROM wine AS novnc

# Install UDP service client
# RUN git clone https://github.com/8cH9azbsFifZ/py_wsjtx.git
# RUN cd py_wsjtx && pip3 install -r requirements.txt
#RUN apt-get -y install mqtt python3-paho-mqtt

ADD ./config/xfce4 /root/.config/xfce4
COPY entrypoint.sh .
COPY ./config/WSJT-X.template.ini .
COPY ./config/WSJT-X.ini .

ENV MYCALL=FIXME
ENV MYGRID=FIXME
ENV RIG=FiFi
ENV SOUNDINPUT=plughw:CARD=FiFiSDR,DEV=0
ENV SOUNDOUTPUT=hw:CARD=Headphones,DEV=0

EXPOSE 8080
EXPOSE 2237

CMD ["./entrypoint.sh"]


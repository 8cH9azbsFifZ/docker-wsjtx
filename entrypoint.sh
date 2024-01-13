#!/bin/bash
tigervncserver -xstartup /usr/bin/xfce4-session -geometry 800x600 -localhost no :1
envsubst < /WSJT-X.template.ini > /root/.config/WSJT-X.ini
cat /root/.config/WSJT-X.ini
DISPLAY=:1 /usr/bin/wsjtx &
/usr/bin/websockify 8080 localhost:5901 --web=/usr/share/novnc/ 

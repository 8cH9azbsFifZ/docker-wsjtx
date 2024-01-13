# docker-wsjtx
Running WSJT-X headless on a remote raspi, i.e. with FiFi-SDR? There is currently no
working / stable commandline service, so we can use docker.

![Example: Running WSJTX in Docker with HTML5](doc/screenshot.png)

# Configuration
MyCall=${MYCALL}
MyGrid=${MYGRID}
Rig=${RIG}

RIG=FiFi FiFi-SDR
SoundInName=${SOUNDINPUT}
plughw:CARD=FiFiSDR,DEV=0

SoundOutName=${SOUNDOUTPUT}

hw:CARD=Headphones,DEV=0

# References
- https://www.server-world.info/en/note?os=Debian_11&p=desktop&f=8
- https://www.server-world.info/en/note?os=Debian_11&p=desktop&f=6
# docker-wsjtx
Running WSJT-X headless on a remote raspi, i.e. with FiFi-SDR? There is currently no
working / stable commandline service, so we can use docker.

![Example: Running WSJTX in Docker with HTML5](doc/screenshot.png)

# Configuration
Use the docker-compose environment varibles for configuring the startup values for:
- MYCALL
- MYGRID
- RIG
- SOUNDINPUT
- SOUNDOUTPUT


# References
- https://www.server-world.info/en/note?os=Debian_11&p=desktop&f=8
- https://www.server-world.info/en/note?os=Debian_11&p=desktop&f=6
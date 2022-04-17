VER=0.4

# Must be LOWERCASE
USER=8ch9azbsfifz
REPO=debian-wine
TAG=docker.pkg.github.com/${USER}/${REPO}/winevnc

build:
	docker build . -t ${TAG}:${VER} -t ${TAG}:latest

run:
	docker run --rm -it -p 8080:8080 ${TAG}:${VER}

push:
	docker push ${TAG}:${VER}

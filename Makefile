VER=0.1

# Must be LOWERCASE
USER=8ch9azbsfifz
REPO=docker-wsjtx
TAG=docker.pkg.github.com/${USER}/${REPO}/wsjtx

build:
	docker build . -t ${TAG}:${VER} -t ${TAG}:latest

run:
	docker run --rm -it -p 8080:8080 ${TAG}:${VER}

push:
	docker push ${TAG}:${VER}

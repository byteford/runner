ARG IMAGE_TAG
FROM ubuntu:24.10

RUN apt-get update
RUN apt-get -y install make git curl

RUN curl -sL "https://raw.githubusercontent.com/crossplane/crossplane/master/install.sh" | sh

COPY /src /make

ARG IMAGE_TAG
FROM ubuntu:${IMAGE_TAG}

USER root:root

RUN apt-get update
RUN apt-get -y install make git

USER 1001:1001

COPY /src /make


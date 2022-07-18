ARG IMAGE_TAG
FROM maven:3-openjdk-${IMAGE_TAG}-slim

RUN apt-get update
RUN apt-get -y install make

COPY /src /make

ENTRYPOINT [ "/bin/sh" ]
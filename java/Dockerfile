ARG IMAGE_TAG=3-openjdk-18-slim
FROM maven:${IMAGE_TAG}

RUN apt-get update
RUN apt-get -y install make

COPY /src /make

ENTRYPOINT [ "/bin/sh" ]
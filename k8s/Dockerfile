ARG IMAGE_TAG
FROM bitnami/kubectl:${IMAGE_TAG}

USER root:root

RUN apt-get update
RUN apt-get -y install make curl

USER 1001:1001

RUN curl -o /tmp/k9s_linux_amd64.deb https://github.com/derailed/k9s/releases/download/v0.32.5/k9s_linux_amd64.deb

RUN dpkg -i /tmp/k9s_linux_amd64.deb

COPY /src /make


ARG IMAGE_TAG
FROM bitnami/kubectl:${IMAGE_TAG}

USER root:root

RUN apt-get update
RUN apt-get -y install make

USER 1001:1001

RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

RUN brew install derailed/k9s/k9s

COPY /src /make


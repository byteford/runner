ARG IMAGE_TAG
FROM bitnami/kubectl:${IMAGE_TAG}

RUN apt-get update
RUN apt-get -y install make

RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

RUN brew install derailed/k9s/k9s

COPY /src /make


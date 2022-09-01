ARG IMAGE_TAG
FROM hashicorp/terraform:${IMAGE_TAG}

RUN apk add --update make curl unzip

RUN curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | sh

COPY /src /make

ENTRYPOINT ["/bin/sh"]
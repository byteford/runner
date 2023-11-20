FROM python:3.12.0-alpine3.18

RUN apk add --update --no-cache make openssh


ARG IMAGE_TAG
RUN pip install ansible==${IMAGE_TAG}

COPY /src /make
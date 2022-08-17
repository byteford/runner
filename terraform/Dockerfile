ARG IMAGE_TAG
FROM hashicorp/terraform:${IMAGE_TAG}

RUN apk add --update make

COPY /src /make

ENTRYPOINT ["/bin/sh"]
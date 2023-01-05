ARG IMAGE_TAG
From golang:1.19-alpine3.16 as builder
RUN apk add --update git make
WORKDIR /tflint
RUN git clone https://github.com/terraform-linters/tflint.git /tflint
RUN make build

FROM hashicorp/terraform:${IMAGE_TAG} as terraform

RUN apk add --update make unzip

COPY --from=builder /tflint/dist/tflint /usr/local/bin

COPY /src /make

ENTRYPOINT ["/bin/sh"]
## 1. 编译golang代码
FROM golang:1.20-alpine AS builder
RUN sed -i "s/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g" /etc/apk/repositories &&\
    apk add --no-cache git bash vim

ENV GOPROXY=https://goproxy.io
ARG GO_DIR=.

WORKDIR /vncproxy

COPY $GO_DIR/go.mod .
COPY $GO_DIR/go.sum .
RUN go mod download
# RUN go mod tidy

COPY $GO_DIR .
RUN chmod +x ./build
RUN dos2unix ./build
RUN ./build
CMD bash

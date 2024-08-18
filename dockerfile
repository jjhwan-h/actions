# docker build -t gopost
# docker run -it gopost 

FROM golang:1.22-alpine3.20 AS builder

# Install git.
# Git is required for fetcching the dependencies.
RUN apk update && apk add --no-cache git

RUN mkdir /pro
ADD ./usePost05.go /pro/
# go.mod 및 go.sum 복사
COPY go.mod go.sum /pro/
WORKDIR /pro
RUN go mod download
RUN go build -o server usePost05.go

FROM alpine:latest

RUN mkdir /pro
COPY --from=builder /pro/server /pro/server
WORKDIR /pro
CMD ["/pro/server"]
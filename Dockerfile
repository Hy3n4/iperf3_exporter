FROM golang:alpine AS build

ARG CGO_ENABLED=0

WORKDIR /go/src
COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN go build -o /go/bin/iperf3_exporter

FROM alpine:latest
LABEL maintainer="Patrik Chadima <hy3nk4@gmail.com>"

RUN apk add --no-cache iperf3
COPY --from=build /go/bin/iperf3_exporter /bin/

ENTRYPOINT ["/bin/iperf3_exporter"]
EXPOSE     9579

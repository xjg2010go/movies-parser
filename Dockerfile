FROM golang:1.16.5 AS builder
WORKDIR /go/src/github.com/lucas/movies-parser
COPY main.go go.mod .
RUN go get -v

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app main.go

FROM alpine:latest
LABEL Maintainer lucas
RUN apk --no-cache add ca-certificates
WORKDIR /root
COPY --from=builder /go/src/github.com/lucas/movies-parser .
CMD ["./app"]

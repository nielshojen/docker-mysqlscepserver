FROM golang:alpine as builder

RUN apk add --no-cache make git
RUN git clone https://github.com/jessepeterson/mysqlscepserver.git /go/src/github.com/jessepeterson/mysqlscepserver

WORKDIR /go/src/github.com/jessepeterson/mysqlscepserver

ENV CGO_ENABLED=0 \
	GOARCH=amd64 \
	GOOS=linux

RUN make

FROM alpine

RUN apk --update add ca-certificates
COPY --from=builder /go/src/github.com/jessepeterson/mysqlscepserver/mysqlscepserver-linux-amd64 /usr/local/bin/mysqlscepserver
RUN chmod a+x /usr/local/bin/mysqlscepserver

COPY run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE 8080

CMD ["/run.sh"]

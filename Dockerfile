FROM alpine

ENV MYSQLSCEPSERVER_VERSION="0.1.1"

RUN apk --no-cache add curl
RUN apk --update add ca-certificates
RUN curl -L https://github.com/jessepeterson/mysqlscepserver/releases/download/v${MYSQLSCEPSERVER_VERSION}/mysqlscepserver-linux-amd64-v${MYSQLSCEPSERVER_VERSION}.zip -o /mysqlscepserver.zip
RUN unzip /mysqlscepserver.zip
RUN rm /mysqlscepserver.zip
RUN mv /mysqlscepserver-linux-amd64 /usr/local/bin/mysqlscepserver
RUN chmod a+x /usr/local/bin/mysqlscepserver
RUN apk del curl

VOLUME "/db"

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/nanomdm"]

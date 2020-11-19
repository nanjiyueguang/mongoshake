FROM golang:latest

RUN git clone https://github.com/alibaba/MongoShake.git

WORKDIR /go/MongoShake

RUN go get -u github.com/kardianos/govendor

ENV GOPATH=/go/MongoShake

WORKDIR /go/MongoShake/src/vendor/

RUN echo $GOPATH

RUN govendor sync -v

RUN echo govendor status | true

RUN go get -u golang.org/x/sync/semaphore

RUN go get -u golang.org/x/text/transform

RUN go get -u golang.org/x/text/unicode/norm

RUN echo $GOPATH

WORKDIR /go/MongoShake

RUN ./build.sh

RUN ls

CMD ["/go/MongoShake/bin/collector" "-conf=/go/MongoShake/conf/collector.conf" "--verbose"]

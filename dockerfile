FROM golang:latest
RUN mkdir /go -p
RUN mkdir /go/src -p
RUN mkdir /go/src/app -p
ADD main.go /go/src/app/
WORKDIR /go/src/app
COPY . /go/src/app
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags '-extldflags "-static"' -o app .
FROM scratch
WORKDIR /app
COPY --from=build-env /go/src/app/app .
ENTRYPOINT [ "./app" ]

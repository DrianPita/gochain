FROM golang AS builder
COPY app.go .
RUN go get -d -v \
    github.com/lib/pq \
    github.com/julienschmidt/httprouter
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

From scratch
COPY --from=builder /go/app .
EXPOSE 8000
ENV IP=0.0.0.0
ENV PORT=8000
ENV POSTGRES_URL=postgres
ENV POSTGRES_PASSWORD=123456789
ENTRYPOINT ["./app"]

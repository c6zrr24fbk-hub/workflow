FROM golang:1.21 AS builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go env
RUN go mod download -x
COPY . .
RUN go build -o app .

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=builder /app/app .
EXPOSE 8080
CMD ["./app"]
FROM golang:1.22-alpine AS builder

WORKDIR /app
RUN apk add --no-cache git ca-certificates

COPY telegram-bot/go.mod telegram-bot/go.sum ./
RUN go mod download

COPY telegram-bot/ .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o kbot main.go

FROM alpine:3.20
RUN apk add --no-cache ca-certificates
WORKDIR /app
COPY --from=builder /app/kbot /app/kbot

ENTRYPOINT ["/app/kbot"]

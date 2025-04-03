# STAGE 1

FROM golang:1.24-alpine AS builder

WORKDIR /usr/src/app

RUN go mod init app

COPY . .
RUN go mod tidy && go build -v -o /usr/local/bin/app ./...

# STAGE 2

FROM scratch

WORKDIR /app

COPY --from=builder /usr/local/bin/app /app/main

ENTRYPOINT [ "/app/main" ]
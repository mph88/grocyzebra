FROM alpine:latest
WORKDIR /app
RUN apk add --no-cache socat curl
COPY scanner.sh /app
RUN chmod +x scanner.sh
EXPOSE 58627
ENTRYPOINT ["./scanner.sh"]

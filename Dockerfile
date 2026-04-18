
FROM alpine:3.20

ARG SB_VER=1.13.8

RUN apk add --no-cache nginx wget tar ca-certificates && \
    wget -O /tmp/sing-box.tar.gz https://github.com/SagerNet/sing-box/releases/download/v${SB_VER}/sing-box-${SB_VER}-linux-amd64.tar.gz && \
    tar -xzf /tmp/sing-box.tar.gz -C /tmp && \
    install /tmp/sing-box-${SB_VER}-linux-amd64/sing-box /usr/local/bin/sing-box && \
    rm -rf /tmp/*

COPY nginx.conf /etc/nginx/nginx.conf
COPY config.json /etc/sing-box/config.json
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh && mkdir -p /run/nginx

EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]

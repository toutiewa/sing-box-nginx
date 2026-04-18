FROM debian:bookworm-slim

ARG SB_VER=1.13.8

RUN apt-get update && \
    apt-get install -y --no-install-recommends nginx wget ca-certificates tar && \
    rm -rf /var/lib/apt/lists/* && \
    wget -O /tmp/sing-box.tar.gz https://github.com/SagerNet/sing-box/releases/download/v${SB_VER}/sing-box-${SB_VER}-linux-amd64.tar.gz && \
    tar -xzf /tmp/sing-box.tar.gz -C /tmp && \
    install /tmp/sing-box-${SB_VER}-linux-amd64/sing-box /usr/local/bin/sing-box && \
    rm -rf /tmp/*

COPY nginx.conf /etc/nginx/nginx.conf
COPY config.json /etc/sing-box/config.json

EXPOSE 80

CMD ["/bin/sh", "-c", "sing-box run -c /etc/sing-box/config.json & exec nginx -g 'daemon off;'"]

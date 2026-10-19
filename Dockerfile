FROM alpine:latest
RUN apk add --no-cache curl unzip && \
    curl -L https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip -o /tmp/xray.zip && \
    unzip /tmp/xray.zip -d /usr/local/bin/ && \
    chmod +x /usr/local/bin/xray && \
    rm /tmp/xray.zip && \
    apk del curl unzip
COPY config.json /etc/xray/config.json
CMD sh -c "sed -i \"s/\$PORT/${PORT:-10000}/g; s/\$UUID/${UUID}/g; s|\$WSPATH|${WSPATH}|g\" /etc/xray/config.json && /usr/local/bin/xray -config /etc/xray/config.json"

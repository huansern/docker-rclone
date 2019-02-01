FROM alpine:3.8

ARG UID=1000
ARG GID=1000

RUN apk add --no-cache ca-certificates && \
addgroup -g $GID rclone && \
adduser -h /rclone -D -u $UID -G rclone rclone && \
wget -q -O /tmp/rclone.zip https://downloads.rclone.org/rclone-current-linux-amd64.zip && \
unzip -j /tmp/rclone.zip -d /tmp && \
mv /tmp/rclone /usr/bin/ && \
rm -rf /tmp/*

USER rclone

WORKDIR /rclone

RUN mkdir -p .config/rclone data && \
echo "rclone --version" >> rclone.sh && \
chmod u=rwx,g=rx,o= rclone.sh

CMD [ "sh", "./rclone.sh" ]
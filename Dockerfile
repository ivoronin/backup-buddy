FROM ubuntu:focal
ENV DEBIAN_FRONTEND noninteractive
ARG GOCRON_VERSION=0.0.5
ARG GOCRON_URL=https://github.com/ivoronin/go-cron/releases/download/v${GOCRON_VERSION}/go-cron_${GOCRON_VERSION}_linux_amd64.tar.gz
RUN apt-get update
RUN apt-get install -y curl sqlite3 restic docker.io
WORKDIR /usr/local/bin
RUN curl -o - -fsSL ${GOCRON_URL} | tar --no-same-owner -xzf - go-cron
WORKDIR /
ENV BACKUP_CRON="0 * * * *"
ENV BACKUP_PATH=/data
ENV BACKUP_KEEP_WITHIN=2m
ENV RESTIC_CACHE_DIR=/cache
ADD entrypoint.sh /
ADD backup.sh /
RUN chmod +x /entrypoint.sh /backup.sh
CMD /entrypoint.sh

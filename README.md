# Backup Buddy

## Usage example
```yaml
version: '3'
services:
  backup:
    container_name: backup
    image: ghcr.io/ivoronin/backup-buddy:latest
    volumes:
      - "/data:/data"
      - "/data/backup/cache:/cache"
      - "/var/run/docker.sock:/var/run/docker.sock"
    environment:
      BACKUP_CRON: "0 0 * * *"
      BACKUP_HOSTNAME: dockerhost
      # Stop this containers during backup session
      BACKUP_STOP_CONTAINERS: "service1 service2 service3"
      RESTIC_REPOSITORY: s3:https://s3.yourcloudprovider.com/backup-bucket
      RESTIC_PASSWORD: "restic repo password"
      AWS_ACCESS_KEY_ID: "aws key id"
      AWS_SECRET_ACCESS_KEY: "aws key secret"
    restart: on-failure
  service1:
    # service1 definition
  service2:
    # service2 definition
  service3:
    # service3 definition
```

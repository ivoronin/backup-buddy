all:
	docker build -t octalwave-backup-sidecar .

test: all
	docker run -ti -e BACKUP_PATH -e BACKUP_HOSTNAME -e RESTIC_REPOSITORY -e RESTIC_PASSWORD -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY -e BACKUP_ON_START=1 -v /var/run/docker.sock:/var/run/docker.sock -v /data:/data:ro -v /data/backup/cache:/cache octalwave-backup-sidecar

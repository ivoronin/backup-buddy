#!/bin/sh

log() {
    echo "$(date -Isecond)" "$@"
}

log "Performing backup"

log "Stopping containers"
for CONTAINER in ${BACKUP_STOP_CONTAINERS}; do
    log "Stopping container ${CONTAINER}..."
    docker stop "${CONTAINER}"
done

log "Backing up data"
restic backup --exclude-caches -H "${BACKUP_HOSTNAME}" "${BACKUP_PATH}"

log "Starting containers"
for CONTAINER in ${BACKUP_STOP_CONTAINERS}; do
    log "Starting container ${CONTAINER}..."
    docker start "${CONTAINER}"
done

log "Backup complete"

log "Remove old snapshots"
restic forget --host "${BACKUP_HOSTNAME}" --keep-within "${BACKUP_KEEP_WITHIN}" --prune --cleanup-cache
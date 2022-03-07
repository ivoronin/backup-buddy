#!/bin/sh
set -e

require_env() {
    if [ "$#" -ne 1 ] || [ -z "$1" ]; then
        echo "require_env requires 1 argument" >&2
        exit 1
    fi
    NAME="$1"
    VALUE=$(printenv "${NAME}") || true
    if [ -z "${VALUE}" ]; then
        echo "ERROR: Environment variable ${NAME} is required but not set" >&2
        exit 1
    fi
}

require_env BACKUP_CRON
require_env BACKUP_PATH
require_env BACKUP_HOSTNAME
require_env RESTIC_REPOSITORY
require_env RESTIC_PASSWORD
require_env AWS_ACCESS_KEY_ID
require_env AWS_SECRET_ACCESS_KEY

[ -n "${BACKUP_ON_START}" ] && /backup.sh
go-cron "${BACKUP_CRON}" /backup.sh

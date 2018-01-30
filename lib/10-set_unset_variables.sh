#!/bin/bash
#
# **  nextcloud_backups_aws_s3  **
# **  check unser variables  **
#
# Utility to make backups of Nextcloud and store them in an S3 bucket
# Set required variables with default values if they are unset
#
# Álvaro Castellano Vela - https://github.com/a-castellano

function set_unset_variables {
    if [[ -z $DATABASE_PORT ]]; then
        DATABASE_PORT=3306
        write_log "DATABASE_PORT has been set to its default value $DATABASE_PORT."
    fi

    if [[ -z $DATABASE_HOST ]]; then
        DATABASE_HOST="localhost"
        write_log "DATABASE_HOST has been set to its default value $DATABASE_HOST."
    fi

    if [[ -z $HTTP_USER ]]; then
        write_log "HTTP_USER has been set to its default value $HTTP_USER."
        HTTP_USER="www-data"
    fi

    if [[ -z $NEXTCLOUD_USERS ]]; then
        write_log "NEXTCLOUD_USERS has been set to its default value $NEXTCLOUD_USERS."
        NEXTCLOUD_USERS='ALL'
    fi
}

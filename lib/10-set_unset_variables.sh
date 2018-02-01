#!/bin/bash
#
# **  nextcloud_backups_aws_s3  **
# **  check unser variables  **
#
# Utility to make backups of Nextcloud and store them in an S3 bucket
# Set required variables with default values if they are unset
#
# Álvaro Castellano Vela - https://github.com/a-castellano

#Logger
source lib/04-logger.sh

function set_unset_variables {
    if [[ -z $DATABASE_PORT ]]; then
        DATABASE_PORT=3306
        if [[ -v VERBOSE ]]; then
            write_log "DATABASE_PORT has been set to its default value $DATABASE_PORT."
        fi
    fi

    if [[ -z $DATABASE_HOST ]]; then
        DATABASE_HOST="localhost"
        if [[ -v VERBOSE ]]; then
            write_log "DATABASE_HOST has been set to its default value $DATABASE_HOST."
        fi
    fi

    if [[ -z $HTTP_USER ]]; then
        HTTP_USER="www-data"
        if [[ -v VERBOSE ]]; then
            write_log "HTTP_USER has been set to its default value $HTTP_USER."
        fi
    fi

    if [[ -z $NEXTCLOUD_USERS ]]; then
        NEXTCLOUD_USERS='ALL'
        if [[ -v VERBOSE ]]; then
            write_log "NEXTCLOUD_USERS has been set to its default value $NEXTCLOUD_USERS."
        fi
    fi

    if [[ -z $EXCLUDE_DATABASE ]]; then
       EXCLUDE_DATABASE=false
       if [[ -v VERBOSE  ]]; then
            write_log "EXCLUDE_DATABASE has been unset, database will be backuped."
       fi
    fi
}

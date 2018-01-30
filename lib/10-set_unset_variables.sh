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
    fi

    if [[ -z $DATABASE_HOST ]]; then
        DATABASE_HOST="localhost"
    fi

    if [[ -z $HTTP_USER ]]; then
        HTTP_USER="www-data"
    fi

    if [[ -z $NEXTCLOUD_USERS ]]; then
        NEXTCLOUD_USERS='ALL'
    fi
}

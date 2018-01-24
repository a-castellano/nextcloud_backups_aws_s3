#!/bin/bash
#
# **  nextcloud_backups_aws_s3  **
# **  check database variables  **
#
# Utility to make backups of Nextcloud and store them in an S3 bucket
# Set required database variables with default values uf they are unset
#
# Álvaro Castellano Vela - https://github.com/a-castellano

function set_unset_database_variables {
    if [[ -z $DATABASE_PORT ]]; then
        DATABASE_PORT=3306
    fi

    if [[ -z $DATABASE_HOST ]]; then
        DATABASE_HOST="localhost"
    fi
}

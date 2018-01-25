#!/bin/bash
#
# **  nextcloud_backups_aws_s3   **
# **      clean variables        **
#
# Utility to make backups of Nextcloud and store them in an S3 bucket
# Clean env variables
#
# Álvaro Castellano Vela - https://github.com/a-castellano

cleanVariables() {
    for var in NEXTCLOUD_PATH NEXTCLOUD_USERS CONFIG_FILE NEXTCLOUD_PATH NEXTCLOUD_CONFIG_ROUTE NEXTCLOUD_CONFIG_FILE VERBOSE HELP USAGE SILENT S3_ACCESS_KEY S3_SECRET_KEY DATABASE_NAME DATABASE_USER DATABASE_PASSWD DATABASE_HOST DATABASE_PORT TEST
    do
        unset $var
    done
}


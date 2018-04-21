#!/bin/bash
#
# **  nextcloud_backups_aws_s3  **
# **   remove database backup   **
#
# Utility to make backups of Nextcloud and store them in an S3 bucket
# Make files backup using s3cmd
#
# Álvaro Castellano Vela - https://github.com/a-castellano

# Logger
source lib/01-default_values_and_commands.sh
source lib/02-usage.sh
source lib/04-logger.sh


function remove_database_backup {

    NEXTCLOUD_DATA_DIR="$NEXTCLOUD_PATH/data"
    write_log "Uploading backups to S3 bucket."
    if [[ $EXCLUDE_DATABASE = false ]]; then
        if [[ -v VERBOSE ]]; then
            write_log "Removing local database backup."
        fi
        $RM $DATABASE_BACKUP_PATH
    fi
    write_log "Local Database Backup Removed."
}

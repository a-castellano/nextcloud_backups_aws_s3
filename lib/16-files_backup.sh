#!/bin/bash
#
# **  nextcloud_backups_aws_s3  **
# **       files backup         **
#
# Utility to make backups of Nextcloud and store them in an S3 bucket
# Make files backup using s3cmd
#
# Álvaro Castellano Vela - https://github.com/a-castellano

# Logger
source lib/01-default_values_and_commands.sh
source lib/02-usage.sh
source lib/04-logger.sh


function backup_files_by_user {

    NEXTCLOUD_DATA_DIR="$NEXTCLOUD_PATH/data"

    if [[ $EXCLUDE_DATABASE=false ]]; then
        $S3CMD --access_key="$S3_ACCESS_KEY" --secret_key="$S3_SECRET_KEY" --storage-class=REDUCED_REDUNDANCY sync --delete-removed --recursive --preserve $DATABASE_BACKUP_PATH s3://$S3_BUCKET
    fi

    for user in $USERS_TO_BACKUP
    do
        $S3CMD --access_key="$S3_ACCESS_KEY" --secret_key="$S3_SECRET_KEY" --storage-class=REDUCED_REDUNDANCY sync --delete-removed --recursive --preserve $NEXTCLOUD_DATA_DIR/$user s3://$S3_BUCKET
    done
}

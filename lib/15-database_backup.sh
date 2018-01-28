#!/bin/bash
#
# **  nextcloud_backups_aws_s3  **
# **      database backup       **
#
# Utility to make backups of Nextcloud and store them in an S3 bucket
# Make a database backup using mydumper
#
# Álvaro Castellano Vela - https://github.com/a-castellano

# Logger
source lib/01-default_values_and_commands.sh
source lib/02-usage.sh
source lib/04-logger.sh

function database_backup {

    if [[ $EXCLUDE_DATABASE=false ]]; then
        $MKDIR $BACKUP_PATH 2> $LOCAL_ERROR_FILE
        if [ $? -ne 0 ]; then
            error_msg=$( $CAT $LOCAL_ERROR_FILE )
            report_error $error_msg
            $RM $LOCAL_ERROR_FILE
            exit 1
        else
            $MYDUMPER --user="$DATABASE_USER" --password="$DATABASE_PASSWORD" --port=$DATABASE_PORT  --database="$DATABASE_NAME" -C --outputdir=$BACKUP_PATH 2> $LOCAL_ERROR_FILE
            $CAT $LOCAL_ERROR_FILE
            if [ $? -ne 0  ]; then
                error_msg=$( $CAT $LOCAL_ERROR_FILE  )
                report_error $error_msg
                $RM $LOCAL_ERROR_FILE
                exit 1
            fi
            $RM $LOCAL_ERROR_FILE
        fi
        $RM $LOCAL_ERROR_FILE
    fi
}

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
    if [[ $EXCLUDE_DATABASE = false ]]; then
        $MKDIR -p $DATABASE_BACKUP_PATH 2> $LOCAL_ERROR_FILE
        if [[ $? -ne 0 ]]; then
            error_msg=$( $CAT $LOCAL_ERROR_FILE )
            report_error $error_msg
            $RM $LOCAL_ERROR_FILE
            exit 1
        else
            write_log "Database backup proccess started."
            $MYDUMPER --user="$DATABASE_USER" --password="$DATABASE_PASSWD" --port=$DATABASE_PORT  --database="$DATABASE_NAME" -C --outputdir=$DATABASE_BACKUP_PATH --no-locks > /dev/null 2> $LOCAL_ERROR_FILE
            if [[ $? -ne 0 ]]; then
                error_msg=$( $CAT $LOCAL_ERROR_FILE )
                report_error $error_msg
                $RM $LOCAL_ERROR_FILE
                exit 1
            fi
            $RM $LOCAL_ERROR_FILE
            write_log "Database backup proccess ended."
        fi
        $RM $LOCAL_ERROR_FILE
    else
        if [[ ! -z $VERBOSE ]]; then
            write_log "Not performing database backup, EXCLUDE_DATABASE is enabled."
        fi
    fi
}

#!/bin/bash
#
# **  nextcloud_backups_aws_s3  **
# **          logger            **
#
# Utility to make backups of Nextcloud and store them in an S3 bucket
# Fucntions for log management
#
# Álvaro Castellano Vela - https://github.com/a-castellano

# Log variables
LOGGET_TAG="nextcloud_backups_aws_s3"
LOGGER="$(which logger) -t $LOGGET_TAG"

# Error file
LOCAL_ERROR_FILE="$TMP_FOLDER/.error.log"

NOW=`$DATE '+%Y-%m-%d %H:%M:%S'`

function report_error {
    error_message="Error: $@"
    stderr=""
    if [[ -z "$SILENT" || "$SILENT" = false ]]; then
       stderr="--stderr"
    fi
    if [[ -w $LOG_FILE ]]; then
        $ECHO "$NOW $error_message" >> $LOG_FILE
    fi
    $LOGGER $stderr $error_message
}

function write_log {
    message="Info: $@"
    $LOGGER $message
    if [[ -w $LOG_FILE ]]; then
        $ECHO "$NOW $error_message" >> $LOG_FILE
    fi
}

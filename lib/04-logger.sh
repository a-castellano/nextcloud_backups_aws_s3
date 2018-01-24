#!/bin/bash
#
# **  nextcloud_backups_aws_s3   **
# **          logger             **
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

function report_error {
    error_message="Error: $@"
    stderr=""
    if [[ -z "$SILENT" || "$SILENT" = false ]]; then
       stderr="--stderr"
    fi
    $LOGGER $stderr $error_message
}

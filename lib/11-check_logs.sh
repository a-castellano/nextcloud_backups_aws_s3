#!/bin/bash
#
# **  nextcloud_backups_aws_s3  **
# **         check logs         **
#
# Utility to make backups of Nextcloud and store them in an S3 bucket
# Check if logging into external file is enabled
#
# Álvaro Castellano Vela - https://github.com/a-castellano

# Logger
source lib/04-logger.sh

function check_log_file {
if [[ "$ENABLE_LOG" = true ]]; then
    if [[ "$ENABLE_LOG" = true && -z $LOG_FILE ]];then
        error_msg="Log enabled but there is no log file declared, add '--log-file' option."
        report_error $error_msg
        exit 1
    else
        # Check if folder is writable
        if [[ -f "$LOG_FILE" ]]; then
            if [[ ! -w "$LOG_FILE" ]];then
                error_msg="Cannot write log in '$LOG_FILE': Permission Denied"
                report_error $error_msg
                exit 1
            fi
        else
            folder=$( $ECHO $LOG_FILE | $SED 's|/[^/]*$||' )
            if [[ -w $folder ]]; then
                $TOUCH $LOG_FILE
            else
                if [[ -d $folder ]]; then
                    error_msg="Cannot write log in '$folder': Permission Denied"
                    report_error $error_msg
                    exit 1
                else
                    error_msg="Cannot write log in '$folder': Given path does not exist"
                    report_error $error_msg
                    exit 1
                fi
            fi
        fi
    fi
fi
}


#!/bin/bash
#
# **  nextcloud_backups_aws_s3   **
# **      required software      **
#
# Utility to make backups of Nextcloud and store them in an S3 bucket
# Functions to validate if required sowtware is installed
#
# Álvaro Castellano Vela - https://github.com/a-castellano

# Logger
source lib/01-default_values_and_commands.sh
source lib/04-logger.sh

function check_required_software {
    errors=false

    MYSQL=$($WHICH mysql)
    if [[ -z $MYSQL ]]; then
        errors=true
        error_msg="MySQL client is not installed, please install it before start backup jobs."
        report_error $error_msg
    fi

    MYDUMPER=$($WHICH mydumper)
    if [[ -z $MYDUMPER ]]; then
        errors=true
        error_msg="mydumper is not installed, please install it before start backup jobs."
        report_error $error_msg
    fi

    S3CMD=$($WHICH s3cmd)
    if [[ -z $S3CMD ]]; then
        errors=true
        error_msg="s3cmd is not installed, please install it before start backup jobs."
        report_error $error_msg
    fi

    if [[ "$errors" = "true" ]]; then
        exit 1
    fi
}

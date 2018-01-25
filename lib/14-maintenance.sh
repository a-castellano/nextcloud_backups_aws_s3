#!/bin/bash
#
# **  nextcloud_backups_aws_s3  **
# **       maintenance          **
#
# Utility to make backups of Nextcloud and store them in an S3 bucket
# Functions to set/unset nexcloud under maintenance mode
#
# Álvaro Castellano Vela - https://github.com/a-castellano

# Logger
source lib/01-default_values_and_commands.sh
source lib/02-usage.sh
source lib/04-logger.sh

# I don't know how to test these functions

function set_maintenance {
    sudo -u $HTTP_USER -H php $NEXCLOUD_PATH/occ maintenance:mode --on 2> $LOCAL_ERROR_FILE
    if [ $? -ne 0 ]; then
        error_msg=$( $CAT $LOCAL_ERROR_FILE )
        report_error $error_msg
        $RM $LOCAL_ERROR_FILE
        exit 1
    fi
    $RM $LOCAL_ERROR_FILE
}

function unset_maintenance {
    sudo -u $HTTP_USER -H php $NEXCLOUD_PATH/occ maintenance:mode --off 2> $LOCAL_ERROR_FILE
    if [ $? -ne 0 ]; then
        error_msg=$( $CAT $LOCAL_ERROR_FILE )
        report_error $error_msg
        $RM $LOCAL_ERROR_FILE
        exit 1
    fi
    $RM $LOCAL_ERROR_FILE
}

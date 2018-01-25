#!/bin/bash
#
# **  nextcloud_backups_aws_s3  **
# **       check users          **
#
# Utility to make backups of Nextcloud and store them in an S3 bucket
# Check if provided nexcloud users exist
#
# Álvaro Castellano Vela - https://github.com/a-castellano

# Logger
source lib/01-default_values_and_commands.sh
source lib/02-usage.sh
source lib/04-logger.sh

function check_users {
    users_in_database=$(mysql -u$DATABASE_USER -h$DATABASE_HOST -p$DATABASE_PASSWD $DATABASE_NAME --port=$DATABASE_PORT -Bse "select uid from oc_users;")
    if [[ ! "$NEXCLOUD_USERS" -ne "ALL" ]]; then
        provided_users=$($ECHO $NEXCLOUD_USERS | $SED '/,/ /')
        lost_users=""
        for user in $NEXCLOUD_USERS
        do
            if ! $ECHO $users_in_database | $GREP -w $user > /dev/null; then
                lost_users="$user $lost_users"
            fi
        done
        if [ "$lost_users" -ne "" ]; then
            error_msg="The following users are not present as Nexcloud users: $lost_users. Please, provide a valid list of users."
            report_error $error_msg
            usage
            exit 1
        fi
}

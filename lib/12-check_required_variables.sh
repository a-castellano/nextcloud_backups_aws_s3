#!/bin/bash
#
# **  nextcloud_backups_aws_s3   **
# **  check required variables   **
#
# Utility to make backups of Nextcloud and store them in an S3 bucket
# Check if all required varible for running the script are set
#
# Álvaro Castellano Vela - https://github.com/a-castellano

# Logger
source lib/01-default_values_and_commands.sh
source lib/02-usage.sh
source lib/04-logger.sh

function test_function {
    exit 0
}

function check_required_variables {
    declare -a required_variables
    required_variables=(
        's3-access-key'
        's3-secret-key'
        's3-bucket'
        'database-name'
        'database-user'
        'database-passwd'
        'database-host'
        'database-port'
        'nextcloud-path'
        'nextcloud-users'
    )

    unset_variables=""
    for var in ${required_variables[@]}
    do
        variable=$($ECHO $var | $TR '[:lower:]' '[:upper:]' | $TR '-' '_' )
        if [[ -z ${!variable} ]]; then
            unset_variables="$unset_variables, $var"
        fi
    done
    if [[ ! "$unset_variables" = "" ]]; then
        unset_variables=$($ECHO $unset_variables | $SED 's/,//' )
        error_msg="The following variables has to have value: $unset_variables. Please set a valid value for it."
        report_error $error_msg
        usage
        exit 1
    fi
}

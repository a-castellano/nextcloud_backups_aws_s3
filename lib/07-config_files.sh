#!/bin/bash
#
# **  nextcloudbackupsawss3  **
# **        conig_files         **
#
# Utility to make backups of Nextcloud and store them in an S3 bucket
# Functions to validate config files
#
# Álvaro Castellano Vela - https://github.com/a-castellano

declare -a required_config_variables

required_config_variables=(
    'S3_ACCESS_KEY'
    'S3_SECRET_KEY'
    'S3_BUCKET'
    'DATABASE_NAME'
    'DATABASE_PASSWD'
    'DATABASE_PORT'
    'DATABASE_USER'
    'DATABASE_HOST'
    'NEXTCLOUD_USERS'
    'LOG_FILE'
)

declare -A variables_to_nextcloud_variables=(
    ["DATABASE_NAME"]="dbname"
    ["DATABASE_HOST"]="dbhost"
    ["DATABASE_PORT"]="dbport"
    ["DATABASE_USER"]="dbuser"
    ["DATABASE_PASSWD"]="dbpassword"
)


function test_config_file {
    file=$1

    if [[ ! -f $file ]]; then
        error_msg="Config file '$file' does not exist."
        report_error $error_msg
        exit 1
    fi
    if [[ ! -r $file ]]; then
        error_msg="Can't read '$file', permission denied."
        report_error $error_msg
        exit 1
    fi
}

function get_variables_config_file {

    CONFIG_FILE=$( $ECHO $CONFIG_FILE | $SED "s|~|$HOME|" )
    test_config_file $CONFIG_FILE

    if [[ -v VERBOSE  ]]; then
        write_log "Recollecting variable from $CONFIG_FILE"
    fi

    for var in "${required_config_variables[@]}"
    do
        if [[ -z ${!var} ]]; then
            value=$( $GREP $var $CONFIG_FILE | $SED "s|$var[ ]*=[ ]*||")
            if [[ ! "$value" = "" ]]; then
                if [[ -v VERBOSE ]]; then
                    write_log "    $var=$value"
                fi
                eval $var=$value
            fi
        fi
    done

}

function get_variables_from_nextcloud_config_file {

    nextcloud_config_file=$NEXTCLOUD_PATH$NEXTCLOUD_CONFIG_ROUTE
    test_config_file $nextcloud_config_file

    if [[ -v VERBOSE  ]]; then
        write_log "Recollecting variable from $nextcloud_config_file"
    fi

    for var in "${!variables_to_nextcloud_variables[@]}"
    do
        if [[ -z ${!var} ]]; then
            value=$( $GREP ${variables_to_nextcloud_variables[$var]} $nextcloud_config_file | $SED "s/^.* => '//" | $SED "s/',$//" )
            if [[ ! "$value" = "" ]]; then
                if [[ -v VERBOSE ]]; then
                    write_log "    $var=$value"
                fi
                eval $var=$value
            fi
        fi
    done
}

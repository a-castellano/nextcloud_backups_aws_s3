#!/bin/bash
#
# **  nextcloudbackupsawss3  **
# **        test_options        **
#
# Utility to make backups of Nextcloud and store them in an S3 bucket
# Functions to display if required variables exists
#
# Álvaro Castellano Vela - https://github.com/a-castellano

function variables_to_test {
    variables_to_test=$( $ECHO $1 | $SED 's/,/ /g' | $TR '[:lower:]' '[:upper:]' | $TR '-' '_' )
    for var in $variables_to_test
    do
        if [[ -z ${!var} ]]; then
            $ECHO "$var is not defined"
        else
            $ECHO "$var -> ${!var}"
        fi
    done
}

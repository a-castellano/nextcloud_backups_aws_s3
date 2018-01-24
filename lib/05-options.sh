#!/bin/bash
#
# **  nextcloud_backups_aws_s3   **
# **         options             **
#
# Utility to make backups of Nextcloud and store them in an S3 bucket
# Fucntions and variablesfor managing options passed to the script
#
# Álvaro Castellano Vela - https://github.com/a-castellano

# Options
declare -A short_options_array=(
   ["h"]="help"
)

#Because of the eval below, --help option can't exist
short_options_array_list=$( $ECHO "${!short_options_array[@]}" | $SED 's/ //g' )
short_options_array_OR=$( $ECHO "${!short_options_array[@]}" | $SED 's/\([^ ]\)/-\1 |/g' | $SED 's/|$//g' )

declare -A short_options_hash=(
    ["v"]="verbose"
    ["s"]="silent"
    ["u"]="usage"
    ["l"]="enable-log"
)
short_options=$( $ECHO "${!short_options_hash[@]}" | $SED 's/ //g' )
short_options_OR=$( $ECHO "${!short_options_hash[@]}" | $SED 's/\([^ ]\)/-\1 |/g' | $SED 's/|$//g' )

of_short=$(for KEY in "${!short_options_hash[@]}"; do $PRINTF "${short_options_hash[$KEY]},"; done )
of_short_OR=$(for KEY in "${!short_options_hash[@]}"; do $PRINTF "--${short_options_hash[$KEY]} | "; done | $SED 's/| $//g' )

declare -a long_options_with_no_params_array
long_options_with_no_params_array=(
    'exclude-database'
    'dry-run'
)
no_params=$( $ECHO ${long_options_with_no_params_array[@]} | $SED 's/ /,/g' | $SED 's/$/,/g' )
no_params_OR=$( $ECHO ${long_options_with_no_params_array[@]} | $SED 's/\([^ ]*\)/--\1 |/g' | $SED 's/|$//g' )

declare -a long_options_with_one_param_array
long_options_with_one_params_array=(
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
    'log-file'
    'config-file'
    'test'
)
one_param=$( $ECHO ${long_options_with_one_params_array[@]} | $SED 's/ /:,/g' | $SED 's/$/:,/g' )
one_param_OR=$( $ECHO ${long_options_with_one_params_array[@]} | $SED 's/\([^ ]*\)/--\1 |/g' | $SED 's/|$//g' )

#Functions

function check_option_called {
    values=$( $ECHO $@ | $CUT -d " " -f2- | $SED 's/[ ]*//g' )
    option_called="_OPTION_CALLED"
    option_name=$( $ECHO $@ | $CUT -d " " -f1 )
    variable_name=$( $ECHO $option_name | $TR '[:lower:]' '[:upper:]' | $TR '-' '_' )
    variable_called_name="$variable_name$option_called"
    if [[ -z ${!variable_called_name} || "${!variable_called_name}" = false  ]]; then
        if [ "$#" -eq 1 ]; then
            eval $variable_name=true
        fi
        if [ "$#" -gt 1 ]; then
            eval $variable_name=$values
            if [ -z "$variable_name" ]; then
                error_msg="$variable_name was supposed to be set. Can't parse '$2'."
                report_error $error_msg
                exit 1
            fi
        fi
        eval $variable_called_name=true
    else
        error_msg="It is not allowed to set $option_name options more than two times."
        report_error $error_msg
        exit 1
    fi
}

function get_option_from_short_options_array {
    arg=$(trim $1)
    result=${short_options_array[$arg]}
    check_option_called $result
}

function get_option_from_short_options_hash {
    arg=$( trim $1 )
    result=${short_options_hash[$arg]}
    check_option_called $result
}

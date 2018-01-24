#!/bin/bash
#
# **  nextcloud_backups_aws_s3   **
# ** default_values_and_commands **
#
# Utility to make backups of Nextcloud and store them in an S3 bucket
# Default values and commands as variables
#
# Álvaro Castellano Vela - https://github.com/a-castellano

# Option variables
ENABLE_LOG=false # by default this script write logs via syslog

# Default values
if [[ -z $NEXTCLOUD_PATH ]]; then
    NEXTCLOUD_PATH='/var/www/nextcloud'
fi

if [[ -z $CONFIG_FILE  ]]; then
    CONFIG_FILE='~/.config/nextcloud_backups_aws_s3'
fi

# Nextcloud variables
NEXTCLOUD_CONFIG_ROUTE='/config/config.php'
NEXTCLOUD_USERS='ALL'

# Log variables
LOGGET_TAG="nextcloud_backups_aws_s3"
LOGGER="$(which logger) -t $LOGGET_TAG"

# App tmp folder
TMP_FOLDER="/var/tmp/nextcloud_backups_aws_s3"
# Error file
LOCAL_ERROR_FILE="$TMP_FOLDER/.error.log"

# Misc
WHICH=$(which which)
ECHO=$($WHICH echo)
TR=$($WHICH tr)
RM=$($WHICH rm)
SED=$($WHICH sed)
CAT=$($WHICH cat)
PRINTF=$($WHICH printf)
CUT=$($WHICH cut)
TOUCH=$($WHICH touch)
GREP=$($WHICH grep)
MKDIR=$($WHICH mkdir)

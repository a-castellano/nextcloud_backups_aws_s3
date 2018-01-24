#!/bin/bash
#
# **  nextcloud_backups_aws_s3   **
# **      check connections      **
#
# Utility to make backups of Nextcloud and store them in an S3 bucket
# Check mysql and s3cmd behavior
#
# Álvaro Castellano Vela - https://github.com/a-castellano

# Logger
source lib/04-logger.sh

function check_databse_connection {
    TEST=$( mysql -u$DATABASE_USER -p$DATABASE_PASSWD --port=$DATABASE_PORT -h $DATABASE_HOST -Bse "use $DATABASE_NAME" 2> $LOCAL_ERROR_FILE > /dev/null )
    if [ $? -ne 0 ]; then
        error_msg=$( $CAT $LOCAL_ERROR_FILE )
        report_error $error_msg
        $RM $LOCAL_ERROR_FILE
        exit 1
    fi
    $RM $LOCAL_ERROR_FILE
}

function check_s3_conection {
    TEST=$( s3cmd --access_key=$S3_ACCESS_KEY --secret_key=$S3_SECRET_KEY info s3://$S3_BUCKET 2> $LOCAL_ERROR_FILE > /dev/null )
    if [ $? -ne 0 ]; then
        error_msg=$( $CAT $LOCAL_ERROR_FILE )
        report_error $error_msg
        $RM $LOCAL_ERROR_FILE
        exit 1
    fi
    $RM $LOCAL_ERROR_FILE
}


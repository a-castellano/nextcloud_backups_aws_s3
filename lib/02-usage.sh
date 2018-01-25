#!/bin/bash
#
# **  nextcloud_backups_aws_s3  **
# **          usage             **
#
# Utility to make backups of Nextcloud and store them in an S3 bucket
# Fucntion which prints usage
#
# Álvaro Castellano Vela - https://github.com/a-castellano

function usage {
$CAT << EOF
Usage: nextcloud_backups_aws_s3 [OPTIONS] [ARGUMENTS]
Make backups of Nextcloud and store them in an S3 bucket.

For avoiding user to wirte thier secret credentials in the command line
this script will look for config variables in ~/.config/nextcloud_backups_aws_s3
folder. In that folder users can place a files or files contining their
database credentials, S3 access keys, etc.

Arguments:

    --s3-access-key=YOUR_S3_ACCES_KEY
    --s3-secret-key=YOUR_S3_SECRET_KEY
    --database-name=DATABASE_NAME
    --database-user=DATABASE_USER_NAME
    --database-passwd=DATABASE_PASSWORD
    --database-host=DATABSE_HOST           (IP or domain)
    --database-port=PORT                   By default it will be 3306.
    --config-file=PATH_TO_FILE             File containing script config
                                             by default it will be
                                             ~/.config/nextcloud_backups_aws_s3.
    --nextcloud-users="user1,user2"        By default this script will backup
                                             all users folders.
    --nextcloud-path=PATH                  Nexcloud path is /var/www/nextcloud
                                             by default.
    --test="argument,argument2"            Prints valuw of selected arguments.

    Nexcloud users and test varibales can be separated by spaces

Options:

    -h                                    Prints this text.
    -u --usage                            Prints this text.
    -v --verbose                          Enables verbose output.
    -s --silent                           Disable any output in STDOUT.
    -l --enable-log                       By default this scripts uses syslog
                                            for logging with this option enables
                                            it also write logs in the file
                                            spefied in "--logfile" option.
    --log-file=FILE                       In addition to write logs in syslog the
                                            logs will be written in the file provided.
    --exclude-database                    Exclude Nextcloud databse form backups.
    --dry-run                             Perform a trial run with no changes made.
    --http-user                           User who is running Nexcloud (www-data by default)


Exit status:
 0  if OK,
 1  if minor problems (e.g., some important variables are not set),
 2  if serious trouble (e.g., cannot perform the backup).
EOF
}


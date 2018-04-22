#!/bin/bash
#
# **  nextcloudbackupsawss3  **
# **          utils             **
#
# Utility to make backups of Nextcloud and store them in an S3 bucket
# Fucntion functions used by many parts of this script
#
# Álvaro Castellano Vela - https://github.com/a-castellano

function trim {
    $ECHO $1 | $SED 's/^-*//'
}


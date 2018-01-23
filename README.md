# nextcloud_backups_aws_s3

[![Build Status](https://travis-ci.org/a-castellano/nextcloud_backups_aws_s3.svg?branch=unit_tests)](https://travis-ci.org/a-castellano/nextcloud_backups_aws_s3)

Utility to make backups of Nextcloud and store them in an S3 bucket

## Requirements

You will need the following:
- A server using Nextcloud
- An AWS account
- A S3 bucket
- An user with access to that bucket
- The command-line Amazon S3 client -> [s3cmd](http://s3tools.org/s3cmd)
- [myumper](https://github.com/maxbube/mydumper) -> High-performance MySQL backup tool.
- User allowed to run commands as HTTP user. **Don't use root**


Install required packages
```
apt-get install s3cmd mydumper
```

AWS user you create should be in a group with the following policy:
```
{
  "Statement": [
    {
      "Action": "s3:*",
      "Effect": "Allow",
      "Resource": [
        "arn:aws:s3:::your-bucket",
        "arn:aws:s3:::your-bucket/*"
      ]
    }
  ]
}
```

After creating the user you should be able to list your bucket, but not the others.

```
$ s3cmd --access_key=YOUR_ACCESS_KEY --secret_key=YOUR_SECRET_KEY ls s3://your-bucket
2018-01-07 16:19      5588   s3://your-bucket/some.file
```

```
$ s3cmd --access_key=YOUR_ACCESS_KEY --secret_key=YOUR_SECRET_KEY ls
ERROR: S3 error: 403 (AccessDenied): Access Denied
```

There shoud exist an admin user able to run commands as the HTTP user of your server.
If your user is called **admin** and HTTP user is **www-data** place the following config into sudoers file.

```
user ALL=(www-data) NOPASSWD: ALL
```
Now, this user is able to put Nexcloud on maintenance mode.

```
$ sudo -u www-data -H php PATH_TO_NEXCLOUD/occ maintenance:mode --on
Maintenance mode enabled

sudo -u www-data -H php PATH_TO_NEXCLOUD/occ maintenance:mode --off
Nextcloud is in maintenance mode - no app have been loaded

Maintenance mode disabled
```

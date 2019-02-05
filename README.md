# nextcloudbackupsawss3

[![pipeline master status](https://git.windmaker.net/a-castellano/nextcloud_backups_aws_s3/badges/master/pipeline.svg)](https://git.windmaker.net/a-castellano/nextcloud_backups_aws_s3/commits/master)
[![Build Status](https://travis-ci.org/a-castellano/nextcloud_backups_aws_s3.svg?branch=master)](https://travis-ci.org/a-castellano/nextcloud_backups_aws_s3)

Utility to make backups of Nextcloud and store them into S3 bucket


## Instalation

### Debian/Ubuntu

This script is available through my repo:
```
wget -O - https://packages.windmaker.net/WINDMAKER-GPG-KEY.pub | sudo apt-key add -
echo "deb http://packages.windmaker.net/ any main" > /etc/apt/sources.list.d/windmaker.list
apt-get update
apt-get install nextcloudbackupsawss3
```

### Build it

```
git clone https://github.com/a-castellano/nextcloud_backups_aws_s3.git nextcloudbackupsawss3
cd nextcloudbackupsawss3
make build
sudo make install
```
You will also need the following packages (Debian package has them as dependence):
- The command-line Amazon S3 client -> [s3cmd](http://s3tools.org/s3cmd)
- [mydumper](https://github.com/maxbube/mydumper) -> High-performance MySQL backup tool.
```
apt-get install s3cmd mydumper
```

## Requirements

You will need the following:
- A server using Nextcloud
- An AWS account
- A S3 bucket
- An user with access to that bucket
- User allowed to run commands as HTTP user.

AWS user you create should be in a group with the following policy:
```
{
  "Version": "2012-10-17",
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
admin ALL=(www-data) NOPASSWD: ALL
```
Now, this user is able to put Nexcloud on maintenance mode.

```
$ sudo -u www-data -H php PATH_TO_NEXTCLOUD/occ maintenance:mode --on
Maintenance mode enabled

sudo -u www-data -H php PATH_TO_NEXTCLOUD/occ maintenance:mode --off
Nextcloud is in maintenance mode - no app have been loaded

Maintenance mode disabled
```

## Usage example

Exclude database from backups
```
nextcloudbackupsawss3 --exclude-databse
```

Make backups only for certain users
```
nextcloudbackupsawss3 --users="undu"
```
```
nextcloudbackupsawss3 --users="undu,maitesin"
```

View your variables values.
```
nextcloudbackupsawss3 --test="s3-access-key,s3-bucket"
```

You can also create a cron task
```
0 1 * * * nextcloudbackupsawss3
```

## To Do (2018-04-23)
- S3 storage class is hardcoded to cheaper one, make it eligible.
- Make database backup folder eligible.
- Allow to choose between MySQL tcp port or socket.
- Send e-mails informing about backup process.
- Create RPM package.

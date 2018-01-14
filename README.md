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

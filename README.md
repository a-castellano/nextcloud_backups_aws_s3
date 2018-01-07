# nexcloud_backups_aws_a3

Utility to make backups of Nextcloud and store them in an S3 bucket

## Requirements

You will need the following:
- A server using Nexcloud
- An AWS account
- A S3 bucket
- An user with access to that bucket
- The command-line Amazon S3 client -> [s3cmd](http://s3tools.org/s3cmd)

For the user you have to create group with the following policy:
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
Include your use to that group.

After creating the user you should be able to list your bucket, but not the others.

```
$ s3cmd --access_key=YOUR_ACCESS_KEY --secret_key=YOUR_SECRET_KEY ls s3://your-bucket
2018-01-07 16:19      5588   s3://your-bucket/some.file
```

```
$ s3cmd --access_key=YOUR_ACCESS_KEY --secret_key=YOUR_SECRET_KEY ls
ERROR: S3 error: 403 (AccessDenied): Access Denied
```

# Dockerised SCM Backup
[![GitHub](https://img.shields.io/badge/GitHub-juroteam%2Fdocker--scm--backup-blue?style=flat-square&logo=github)](https://github.com/juroteam/docker-scm-backup)

[SCM Backup](https://scm-backup.org/) in a Docker container. Default configuration is preset to work with Github.

## Environment Variables

To run this project, you will need the following environment variables

**Required:**

`GH_ORG`

`GH_USER`

`GH_PASS`

**Optional:**

`S3_BUCKET` - If provided, backups will be configured to use S3 storage

> **Note:** When using S3 backup, you are responsible for configuring AWS authentication (credentials, IAM roles, etc.) in your Docker environment.

## Usage/Examples

```shell
docker run -v ${LOCAL_BACKUP_DIRECTORY}:/opt/scm-backup/backup \
           -e GH_USER=username \
           -e GH_PASS=app_password \
           -e GH_ORG=org \
           juroapp/scm-backup
```

**With S3 backup enabled:**
```shell
docker run -v ${LOCAL_BACKUP_DIRECTORY}:/opt/scm-backup/backup \
           -e GH_USER=username \
           -e GH_PASS=app_password \
           -e GH_ORG=org \
           -e S3_BUCKET=my-backup-bucket \
           juroapp/scm-backup
```

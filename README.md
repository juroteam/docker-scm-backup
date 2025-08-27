# Dockerised SCM Backup

[SCM Backup](https://scm-backup.org/) in a Docker container. Default configuration is preset to work with Github.

## Environment Variables

To run this project, you will need the following environment variables

**Required:**
`GH_ORG`

`GH_USER`

`GH_PASS`

**Optional:**
`S3_BUCKET` - If provided, backups will be configured to use S3 storage

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

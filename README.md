# Dockerised SCM Backup

[SCM Backup](https://scm-backup.org/) in a Docker container. Default configuration is preset to work with Github.

## Environment Variables

To run this project, you will need the following environment variables

`GH_ORG`

`GH_USER`

`GH_PASS`

## Usage/Examples

```shell
docker run -v ${LOCAL_BACKUP_DIRECTORY}:/opt/scm-backup/backup \
           -e GH_USER=username \
           -e GH_PASS=app_password \
           -e GH_ORG=org \
           juroapp/scm-backup
```
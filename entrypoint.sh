#!/bin/sh
set -eu

: "${GH_ORG:?GH_ORG is required}"
: "${GH_USER:?GH_USER is required}"
: "${GH_PASS:?GH_PASS is required}"
: "${SCM_LOCAL_FOLDER:?SCM_LOCAL_FOLDER is required}"

# Base configuration
yq e -i '
  .localFolder = env(SCM_LOCAL_FOLDER)
  | with(.sources[] | select(.title == "github");
      .name = env(GH_ORG)
    | .authName = env(GH_USER)
  )
' settings.yml

# Add S3 configuration if S3_BUCKET is provided
if [ -n "${S3_BUCKET:-}" ]; then
  yq e -i '.options.backup.s3BucketName = env(S3_BUCKET)' settings.yml
fi

exec dotnet ScmBackup.dll

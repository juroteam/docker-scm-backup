#!/usr/bin/env bash
set -euo pipefail

yq e -i '(.sources[] | select(.title == "github").name) = env(GH_ORG)' settings.yml
yq e -i '(.sources[] | select(.title == "github").authName) = env(GH_USER)' settings.yml
yq e -i '(.sources[] | select(.title == "github").password) = env(GH_PASS)' settings.yml

exec dotnet ScmBackup.dll
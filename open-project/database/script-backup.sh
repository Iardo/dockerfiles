#!/bin/bash
set -e

timestamp=$(date +"%Y.%m.%d-%H.%M.%S")
pgdataname="${timestamp}-pgdata.tar.gz"
opdataname="${timestamp}-opdata.tar.gz"

if ! [ -d /backups ]; then
  mkdir -p /backups
fi

cd /backups
echo "Backing up PostgreSQL data into backups/${pgdataname}..."
tar czf "${pgdataname}" -C "$PGDATA" .
echo "Backing up OpenProject assets into backups/${opdataname}..."
tar czf "${opdataname}" -C "$OPDATA" .
echo "DONE"

#!/bin/bash
set -e

timestamp=$(date +"%Y.%m.%d-%H.%M.%S")
pgdata="${timestamp}-pgdata.tar.gz"
opdata="${timestamp}-opdata.tar.gz"

if ! [ -d /backups ]; then
  mkdir -p /backups
fi

cd /backups
echo "Backing up PostgreSQL data into backups/${filename}..."
tar czf "${pgdata}" -C "$PGDATA" .
echo "Backing up OpenProject assets into backups/${filename}..."
tar czf "${opdata}" -C "$OPDATA" .
echo "DONE"

#!/bin/bash
set -e
set -o pipefail

# Docker container names
CONTAINER_WEB="infisical-web"
CONTAINER_DATABASE="infisical-database"
FOLDER_BACKUPS="./backups"
TIMESTAMP=$(date +"%Y.%m.%d-%H.%M.%S")

# Create Backups folder
mkdir -p $FOLDER_BACKUPS

# Create Temporary folder
mkdir -p $TIMESTAMP-backup

# Dump DB into SQL File
echo -n "Exporting database ..."
docker exec -t $CONTAINER_DATABASE pg_dumpall -c -U postgres > $TIMESTAMP-backup/postgres.sql
echo "Success!"

# Create tgz
echo -n "Generating tarball $TIMESTAMP-backup.tgz ..."
tar -czf $FOLDER_BACKUPS/$TIMESTAMP-backup.tgz \
  $TIMESTAMP-backup/postgres.sql
echo "Success!"

# Remove source files
echo -n "Cleaning up temporary files ..."
rm -rf $TIMESTAMP-backup
echo "Success!"

echo -e "\nBackup Complete!\n"

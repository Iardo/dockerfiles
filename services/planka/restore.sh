#!/bin/bash
set -e
set -o pipefail

# Docker container names
PLANKA_DOCKER_CONTAINER_PLANKA="planka-web"
PLANKA_DOCKER_CONTAINER_POSTGRES="planka-database"
PLANKA_BACKUP_ARCHIVE_TGZ=$1
PLANKA_BACKUP_ARCHIVE=$(basename $PLANKA_BACKUP_ARCHIVE_TGZ .tgz)

LOG_FOLDER="./logs"
LOG_FILE=$LOG_FOLDER/${PLANKA_BACKUP_ARCHIVE}-restore.txt

# Create Logs folder
mkdir -p $LOG_FOLDER

# Extract tgz archive
echo -n "Extracting tarball $PLANKA_BACKUP_ARCHIVE_TGZ ..."
tar -xzf $PLANKA_BACKUP_ARCHIVE_TGZ
echo "Success!"

# Import Database
echo -n "Importing database ..."
cat $PLANKA_BACKUP_ARCHIVE/postgres.sql | docker exec -i $PLANKA_DOCKER_CONTAINER_POSTGRES psql -U postgres -q > $LOG_FILE
echo "Success!"

# Restore Docker Volumes
echo -n "Importing images-avatars ..."
docker run --rm --volumes-from $PLANKA_DOCKER_CONTAINER_PLANKA -v $(pwd)/$PLANKA_BACKUP_ARCHIVE:/backup ubuntu cp -rf /backup/user-avatars /app/public/
echo "Success!"
echo -n "Importing images-background ..."
docker run --rm --volumes-from $PLANKA_DOCKER_CONTAINER_PLANKA -v $(pwd)/$PLANKA_BACKUP_ARCHIVE:/backup ubuntu cp -rf /backup/project-background-images /app/public/
echo "Success!"
echo -n "Importing attachments ..."
docker run --rm --volumes-from $PLANKA_DOCKER_CONTAINER_PLANKA -v $(pwd)/$PLANKA_BACKUP_ARCHIVE:/backup ubuntu cp -rf /backup/attachments /app/private/
echo "Success!"

echo -n "Cleaning up temporary files and folders ..."
rm -r $PLANKA_BACKUP_ARCHIVE
echo "Success!"

echo -e "\nRestore complete!\n"

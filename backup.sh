#!/usr/bin/env bash

set -e

echo "Archiving... This may take a while"

rsync --archive \
      --delete \
      --exclude node_modules \
      --exclude Downloads \
      --exclude elpa \
      --exclude Android \
      --exclude .local \
      --exclude secrets \
      --exclude .git \
      --exclude Work \
      --filter ':- .gitignore' \
      ~ \
      /tmp/backup

zip -rq /tmp/backup.zip /tmp/backup

cp /tmp/backup.zip ~/Downloads/
rm /tmp/backup.zip

echo -e "Backed up to ~/Downloads/backup.zip"

# Eventually set backups, like:
# | tee /Volumes/BackupDrive/backup.log

rsync --archive \
      --delete \
      --progress \
      --human-readable \
      --exclude node_modules \
      --exclude elpa \
      --exclude Android \
      --exclude Applications \
      --exclude secrets \
      --exclude Work \
      --exclude cache \
      ~ \
      remote-machine:backup

# Eventually set backups, like:
# | tee /Volumes/BackupDrive/backup.log

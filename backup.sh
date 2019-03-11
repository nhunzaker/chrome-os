#!/usr/bin/env bash

set -e

TARGET=/tmp/backups
FILENAME=backup-$(date --iso-8601).zip

echo "Archiving... This may take a while"

cd $HOME

mkdir -p $TARGET

rsync --archive \
      --delete \
      --relative \
      --exclude node_modules \
      --exclude elpa \
      --exclude .git \
      --filter ':- .gitignore' \
      .AndroidStudio*/config \
      .config/terminator \
      .config/fish \
      .emacs.d/init.el \
      .emacs.d/themes \
      .fonts \
      .gitconfig \
      .gnupg \
      .org \
      .ssh \
      $TARGET

cd $TARGET

zip -r -q "$FILENAME" .

mkdir -p ~/Downloads
cp $FILENAME ~/Downloads/
rm $FILENAME

echo -e "Backed up to ~/Downloads/$FILENAME"

# Eventually set backups, like:
# | tee /Volumes/BackupDrive/backup.log

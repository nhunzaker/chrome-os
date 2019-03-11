#!/usr/bin/env bash

set -e

TARGET=$1

read -p "Restoring to $(basename $TARGET). Are you sure? [y/N]" -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo "Okay, restoring to $(basename $TARGET)"
  cd ~
  unzip -o $1
fi

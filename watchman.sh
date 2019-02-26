#!/usr/bin/env bash

###
# Install Watchman for React Native and Jest
# https://facebook.github.io/watchman/
###

RELEASE=v4.9.0
TARGET=~/.local/bin/watchman

###
# Pre-check
###

if [ -f $TARGET ]; then
  echo "✓ Watchman is already installed"
  exit 0
fi

###
# Dependencies
###

sudo apt-get update -qq
sudo apt-get install -y -qq -q build-essential python-dev automake autoconf libtool

###
# Source
###

cd /tmp
git clone https://github.com/facebook/watchman.git
cd watchman
# Make sure we're in a clean state
# https://github.com/facebook/watchman/issues/542
git clean -dfx
git checkout $RELEASE

###
# Build
###

./autogen.sh
./configure --enable-statedir=/tmp
sudo make
sudo make install
sudo mv watchman $TARGET

#!/usr/bin/env bash

# Installs openssl 1.0 for legacy ruby projects

curl https://www.openssl.org/source/openssl-1.0.2q.tar.gz --output openssl-1.0.2q.tar.gz
tar -xf openssl-1.0.2q.tar.gz
cd openssl-1.0.2q.tar.gz
./config
make
make test
sudo make install

# Install some extra dependencies
# https://github.com/rbenv/ruby-build/issues/1146
sudo apt-get install autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev

CC=$(which gcc-6) asdf install ruby 1.9.3-p551

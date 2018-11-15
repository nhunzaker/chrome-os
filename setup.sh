#!/usr/bin/env bash

###############################################################
## HELPERS
###############################################################
title() {
    printf "\033[1;42m"
    printf '%-*s\n' "${COLUMNS:-$(tput cols)}" "  # $1" | tr ' ' ' '
    printf "\033[0m"
    printf "\n\n"
}

breakLine() {
    printf "\n"
    printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
    printf "\n\n"
    sleep .5
}

###############################################################
## GLOBALS
###############################################################
REPO_URL="https://raw.githubusercontent.com/andrewbrg/deb9-dev-machine/master/"
TIMEZONE="America/Los_Angeles"

###############################################################
## INSTALLATION
###############################################################
title "Set your root password";
    sudo passwd root;
breakLine;

title "Prep work";
  chmod 700 ~/.ssh;
  chmod 644 ~/.ssh/*
  chmod 600 ~/.ssh/*_rsa;

  sudo timedatectl set-timezone $TIMEZONE
breakLine;

title "Installing pre-requisite packages";
    cd ~;
    sudo apt update;
    sudo apt install -y \
        apt-transport-https \
        automake \
        build-essential \
        ca-certificates \
        cmake \
        curl \
        dirmngr \
        gksu \
        gnupg2 \
        htop \
        libreadline-dev \
        libssh2-1-dev \
        libssl-dev \
        libtool \
        mlocate \
        preload \
        unzip \
        wget \
        snap \
        ack \
        postgresql \
        libpq-dev \
        inotify-tools \
        zlib1g-dev;

    sudo updatedb;
breakLine;

# Repositories
title "Adding repositories";
    # Yarn Repo
    if [ ! -f /etc/apt/sources.list.d/yarn.list ]; then
        curl -sL "https://dl.yarnpkg.com/debian/pubkey.gpg" | sudo apt-key add -;
        echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list;
    fi

    sudo apt update;
breakLine;

title "Installing Git";
    sudo apt install -y git;
breakLine;

title "Installing asdf"
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.5.0
    . $HOME/.asdf/asdf.sh
breakLine;

title "Installing Node 8 (LTS)"
    asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git;
    bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring;
    asdf install nodejs 8.11.3;
    asdf global nodejs 8.11.3;
breakLine;

title "Installing Yarn";
    sudo apt-get install --no-install-recommends yarn;
breakLine;

title "Installing Android Studio";
    sudo apt install -y default-jre lib32z1 lib32ncurses5 lib32stdc++6;
    mkdir -p ~/Applications;
    mkdir -p ~/cache;
    if [ ! -f ~/cache/android-studio.zip ]; then
      curl https://dl.google.com/dl/android/studio/ide-zips/3.2.0.25/android-studio-ide-181.4987877-linux.zip --output ~/cache/android-studio.zip;
      unzip ~/cache/android-studio.zip -d Applications/
    fi
breakLine;

title "Installing fish shell";
    sudo apt install -y fish man sqlite3;
breakLine;

title "Installing keychain";
    sudo apt install -y keychain
breakLine;

title "Installing Emacs 25";
    sudo apt install -y emacs25;
breakLine;

title "Installing Terminator";
    sudo apt install -y terminator;
breakLine;

# Clean
title "Finalizing & cleaning up...";
    sudo apt --fix-broken install -y;
    sudo apt dist-upgrade -y;
    sudo apt autoremove -y --purge;
breakLine;

echo "Installation complete.";

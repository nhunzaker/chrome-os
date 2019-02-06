#!/usr/bin/env bash

###############################################################
## HELPERS
###############################################################

DIR=$(pwd)/$(dirname $0)
MAGENTA='\033[0;35m'
RED='\033[0;31m'
NO_COLOR='\033[0m'

perform() {
    printf "${MAGENTA}"
    printf '%-*s\n' "${COLUMNS:-$(tput cols)}" "$1" | tr ' ' ' '
    printf "${NO_COLOR}"
    printf "\n"
}

pretty_print() {
  printf "%s\n" "$1" | fold -s
}

danger_print() {
  printf "\n${RED}$1:${NO_COLOR}\n"
}

end() {
    printf "\n"
}

###############################################################
## GLOBALS
###############################################################

if [ -f $DIR/.env ]; then
   source $DIR/.env
else
  danger_print "ERROR"
  pretty_print "No configuration file found. Please copy .env.example to .env and check the values:"
  printf "\n  ${MAGENTA}cp${NO_COLOR} .env.example .env\n\n"
  exit 1
fi

###############################################################
## INSTALLATION
###############################################################

cd ~;

chmod 700 ~/.ssh;
chmod 644 ~/.ssh/*
chmod 600 ~/.ssh/*_rsa;

sudo timedatectl set-timezone $TIMEZONE
printf "\n"
pretty_print "✓ Time zone is $TIMEZONE"
printf "\n"


# Note: This must happen first, otherwise the icon never updates
perform "Installing desktop apps...";
  # Copy over icons
  mkdir -p ~/.local/icons
  cp $DIR/icons/* ~/.local/icons/

  # Install desktop extensions
  desktop-file-install --dir=$HOME/.local/share/applications $DIR/desktop/emacs.desktop
  pretty_print "✓ Emacs"
  desktop-file-install --dir=$HOME/.local/share/applications $DIR/desktop/terminator.desktop
  pretty_print "✓ Terminator"
  # I'm not sure this works... Possibly ChromeOS just doesn't support it:
  # update-desktop-database
end;

perform "Installing pre-requisite packages";
    sudo apt update -qq;
    sudo apt install -qq -q -y \
        ack \
        apt-transport-https \
        xclip \
        autoconf \
        automake \
        build-essential \
        ca-certificates \
        cmake \
        curl \
        default-jre \
        dirmngr \
        git \
        gksu \
        gnupg2 \
        htop \
        imagemagick \
        inotify-tools \
        lib32ncurses5 \
        lib32stdc++6 \
        lib32z1 \
        libffi-dev \
        libncurses-dev \
        libpq-dev \
        libreadline-dev \
        libssh2-1-dev \
        libssl-dev \
        libtool \
        libxslt-dev \
        libyaml-dev \
        mlocate \
        preload \
        snap \
        tree \
        unixodbc-dev \
        unzip \
        wget \
        libgd-tools \
        m17n-docs \
        gawk \
        emacs25 \
        keychain \
        terminator \
        fish man sqlite3 \
        zlib1g-dev;

    sudo updatedb;
end;

perform "Installing asdf"
    if [ ! -x "$(command -v asdf)" ]; then
      git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.5.0
      echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.bashrc
      echo -e '\n. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc
      . $HOME/.asdf/asdf.sh
    fi;
    pretty_print "✓ asdf version manager"
end;

perform "Installing NodeJS"
    if [ ! -d ~/.asdf/plugins/nodejs ]; then
      asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git;
      bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring;
      asdf install nodejs 8.11.3;
      asdf global nodejs 8.11.3;
    fi;
    pretty_print "✓ NodeJS $(node -v)"

    # Yarn Repo
    if [ ! -x "$(command -v yarn)" ]; then
      if [ ! -f /etc/apt/sources.list.d/yarn.list ]; then
        curl -sL "https://dl.yarnpkg.com/debian/pubkey.gpg" | sudo apt-key add -;
        echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list;
        sudo apt update -qq;
      fi
      sudo apt install -y --no-install-recommends yarn;
    fi
    pretty_print "✓ Yarn $(yarn -v)"
end;

perform "Installing Ruby"
    if [ ! -d ~/.asdf/plugins/ruby ]; then
      asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git;
      asdf install ruby 2.5.1;
      asdf global ruby 2.5.1;
    fi;
    pretty_print "✓ $(ruby -v)"
end;

perform "Installing Postgresql";
    # These instructions may be duplicative to previous steps, but the installation
    # time is minimal
    # https://github.com/smashedtoatoms/asdf-postgres
    if [ ! -d ~/.asdf/plugins/postgres ]; then
      asdf plugin-add postgres https://github.com/smashedtoatoms/asdf-postgres.git;
      asdf install postgres 11.1
      asdf global postgres 11.1
      pg_ctl start
      createdb $USER
    fi;
    pretty_print "✓ $(postgres --version)"
end;

perform "Installing Android Studio";
    if [ ! -d ~/.local/applications/android-studio ]; then
      mkdir -p ~/.local/applications;
      curl https://dl.google.com/dl/android/studio/ide-zips/3.3.0.20/android-studio-ide-182.5199772-linux.zip --output /tmp/android-studio.zip;
      unzip /tmp/android-studio.zip -d ~/.local/applications
    fi
    pretty_print "✓ Android Studio"
end;

perform "Configuring Git Stuff":
    # https://github.com/so-fancy/diff-so-fancy
    if [ ! -f ~/.local/bin/diff-so-fancy ]; then
      mkdir -p ~/.local/bin/;
      curl https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy --output ~/.local/bin/diff-so-fancy;
      # https://github.com/so-fancy/diff-so-fancy#usage
      git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX";
    fi;

    pretty_print "✓ Diff So Fancy"

    # https://github.com/so-fancy/diff-so-fancy#improved-colors-for-the-highlighted-bits
    git config --global color.ui true;
    git config --global color.diff-highlight.oldNormal    "red bold";
    git config --global color.diff-highlight.oldHighlight "red bold 52";
    git config --global color.diff-highlight.newNormal    "green bold";
    git config --global color.diff-highlight.newHighlight "green bold 22";
    git config --global color.diff.meta       "yellow";
    git config --global color.diff.frag       "magenta bold";
    git config --global color.diff.commit     "yellow bold";
    git config --global color.diff.old        "red bold";
    git config --global color.diff.new        "green bold";
    git config --global color.diff.whitespace "red reverse";

    git config --global user.name $GIT_NAME
    git config --global user.email $GIT_EMAIL
end;

# Clean
perform "Finalizing & cleaning up...";
    sudo apt --fix-broken install -qq -y;
    sudo apt dist-upgrade -qq -y;
    sudo apt autoremove -qq -y --purge;
end;

pretty_print "Installation complete.";

set EDITOR emacsclient
set ALTERNATE_EDITOR emacs
set REACT_EDITOR emacsclient

set fish_greeting ""

export DISPLAY=:0
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Android
if test -d $HOME/Android
  set ANDROID_HOME $HOME/Android/Sdk
  set PATH $PATH $ANDROID_HOME/tools
  set PATH $PATH $ANDROID_HOME/tools/bin
  set PATH $PATH $ANDROID_HOME/emulator
  set PATH $PATH $ANDROID_HOME/platform-tools

  export ANDROID_HOME
end

# Ruby
set RUBY_CONFIGURE_OPTS "--with-readline-dir=/usr/lib"

# asdf versioning
if test -d $HOME/.asdf
  source "$HOME/.asdf/asdf.fish"
end

# Yarn bin
if test -d $HOME/.config/yarn/global/node_modules
  set PATH $PATH "$HOME/.config/yarn/global/node_modules/.bin/"
end

# Rust
if test -d $HOME/.cargo/bin/
   set PATH $PATH "$HOME/.cargo/bin/"
end

# Local binaries
if test -d $HOME/.local/bin/
  set PATH $PATH "$HOME/.local/bin/"
end

alias be="bundle exec"

set -gx HOSTNAME (hostname)
function keychain_start
  if status --is-interactive;
    keychain --nogui --clear ~/.ssh/id_rsa
    [ -e $HOME/.keychain/$HOSTNAME-fish ]; and . $HOME/.keychain/$HOSTNAME-fish
  end
end

function gz
  echo "orig size    (bytes): "
  cat "$argv[1]" | wc -c
  echo "gzipped size (bytes): "
  gzip -c "$argv[1]" | wc -c
end

set __fish_git_prompt_color_branch magenta
set __fish_git_prompt_color_dirtystate yellow
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_char_dirtystate '*'

function fish_prompt --description 'Write out the prompt'
  # Just calculate these once, to save a few cycles when displaying the prompt
  if not set -q __fish_prompt_normal
    set -g __fish_prompt_normal (set_color normal)
  end

  if not set -q __fish_prompt_cwd
    set -g __fish_prompt_cwd (set_color $fish_color_cwd)
  end

  printf '%s%s%s%s \n●° '  "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal" (__fish_git_prompt)
end

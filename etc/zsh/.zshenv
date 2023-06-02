export BROWSER="firefox"
export WORK_DIR=$HOME/projects #ultimate root workdir for all my stuff
export LOCAL_DIR=$WORK_DIR/.local
export ETC_DIR=$LOCAL_DIR/etc
export PATH=$PATH:$WORK_DIR/.local/bin
export ZDOTDIR=$WORK_DIR/.local/etc/zsh #needs to contain everything regarding zsh

. "$HOME/.cargo/env"

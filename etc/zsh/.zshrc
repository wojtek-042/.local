export PATH=/home/ap/.local/share/gem/ruby/3.0.0/bin:$PATH
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

## Completion

fpath=($ZDOTDIR/zsh-completions/src $fpath)
zmodload zsh/complist
autoload -U compinit; compinit
_comp_options+=(globdots)
source $ZDOTDIR/completion.zsh

## Prompt

#source $ZDOTDIR/prompt_purification_setup.zsh
#autoload -Uz prompt_purification_setup; prompt_purification_setup
#prompt_purification_setup

## Directory stack

setopt AUTO_PUSHD           # Push the current directory visited on the stack.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.
alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index

## VI mode

#bindkey -v
#export KEYTIMEOUT=1
#fpath=($ZDOTDIR/cursor_mode.zsh $fpath)
#source $ZDOTDIR/cursor_mode.zsh
#cursor_mode
#autoload -Uz cursor_mode; cursor_mode
#bindkey -M menuselect 'h' vi-backward-char
#bindkey -M menuselect 'k' vi-up-line-or-history
#bindkey -M menuselect 'l' vi-forward-char
#bindkey -M menuselect 'j' vi-down-line-or-history


## Syntax highlighting

source $ZDOTDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

## bd

source $ZDOTDIR/bd.zsh

## Custom aleeases
source $ZDOTDIR/custom.zsh
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.config/emacs/bin:$PATH
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
source $ZDOTDIR/zsh-git-prompt/zshrc.sh
## an example prompt
#PROMPT="%B%m%~%b$(git_super_status) \$ "
PROMPT='%B%F{9}%n%F{reset} %F{10}%~%F{reset}%b $(git_super_status)$ '
export GIT_EDITOR=vim

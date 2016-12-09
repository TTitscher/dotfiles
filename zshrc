
# History
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000

# set some important options (as early as possible)

# append history list to the history file; this is the default but we make sure
# because it's required for share_history.
setopt append_history

# save each command's beginning timestamp and the duration to the history file
setopt extended_history

# If a new command line being added to the history list duplicates an older
# one, the older command is removed from the list
setopt histignorealldups

# remove command lines from the history list when the first character on the
# line is a space
setopt histignorespace

# if a command is issued that can't be executed as a normal command, and the
# command is the name of a directory, perform the cd command to that directory.
setopt auto_cd

# in order to use #, ~ and ^ for filename generation grep word
# *~(*.gz|*.bz|*.bz2|*.zip|*.Z) -> searches for word not in compressed files
# don't forget to quote '^', '~' and '#'!
setopt extended_glob

# display PID when suspending processes as well
setopt longlistjobs

# report the status of backgrounds jobs immediately
setopt notify

# whenever a command completion is attempted, make sure the entire command path
# is hashed first.
setopt hash_list_all

# not just at the end
setopt completeinword

# Don't send SIGHUP to background processes when the shell exits.
setopt nohup

# make cd push the old directory onto the directory stack.
setopt auto_pushd

# avoid "beep"ing
setopt nobeep

# don't push the same dir twice.
setopt pushd_ignore_dups

# * shouldn't match dotfiles. ever.
setopt noglobdots

# use zsh style word splitting
setopt noshwordsplit


autoload -Uz compinit && compinit
autoload -U colors && colors
autoload -U zcalc
PROMPT="%{$fg[magenta]%}%1~> %{$reset_color%}"

# zhs does not read .inputrc. so define the keys there is a somehow other way 
# to define the keys using some kind of terminal-info. However, this did
# not work out for me. Esp the home and end keys did not work. 
bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line
bindkey "\e[3~" delete-char
bindkey "\e[2~" quoted-insert
bindkey "\e[5~" history-search-backward
bindkey "\e[6~" history-search-forward


alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ls -a'
alias -s pdf='okular'
alias :q='exit'

alias vi=nvim

# make directory and change into it
function mcd() {
  mkdir -p "$1" && cd "$1";
}

# up 4 -> go 4 directories up (i.e cd ../../../..)
function up() {
    ups=""
    for i in $(seq 1 $1)
    do
    ups=$ups"../"
    done
    cd $ups
}


export OMP_NUM_THREADS=1

# 0 -- vanilla completion (abc => abc)
# 1 -- smart case completion (abc => Abc)
# 2 -- word flex completion (abc => A-big-Car)
# 3 -- full flex completion (abc => ABraCadabra)
zstyle ':completion:*' list-colors matcher-list '' \
  'm:{a-z\-}={A-Z\_}' \
  'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}' \
  'r:|?=** m:{a-z\-}={A-Z\_}'

zstyle ':completion:*' menu select

# report about cpu-/system-/user-time of command if running longer than
# 5 seconds
REPORTTIME=5

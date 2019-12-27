# If not running interactively, don't do anything
#[ -z "$PS1" ] && return


### custom installed setup stuff ###
if [ -d /mnt/disk/code/lib ]; then
    export PERLLIB=/mnt/disk/code/lib
fi


if [ -d $HOME/opt/bin ]; then
    export PATH=$HOME/opt/bin:$PATH
    export MANPATH=$HOME/opt/share/man/:$MANPATH
fi

export PATH=$HOME/.gem/ruby/2.2.0/bin:$PATH

### HISTORY SETTING ###

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=10000
HISTTIMEFORMAT='%F %T -> '


function prom1 {
    local BLUE="\[\033[0;34m\]"
    local RED="\[\033[0;31m\]"
    local LIGHT_RED="\[\033[1;31m\]"
    local WHITE="\[\033[1;37m\]"
    local NO_COLOUR="\[\033[0m\]"
    case $TERM in
        xterm*|rxvt*|screen*)
            TITLEBAR='\[\033]0;\u@\h:\w\007\]'
            ;;
        *)
            TITLEBAR=""
        ;;
    esac

    export PS1="${TITLEBAR}\
$BLUE[$RED\$(date +%H%M)$BLUE]\
$BLUE[$LIGHT_RED\u@\h:\w$BLUE]"

    if [ "$(id -u)" -eq 0 ] ; then
        export PS1="$PS1$WHITE#$NO_COLOUR "
    else
        export PS1="$PS1$WHITE\$$NO_COLOUR "
    fi
    PS2='> '
    PS4='+ '
}

prom1

### make ls better ###
alias ls='ls -lGhX --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'


### make cd better
alias cd='ccd'
ccd() {
    #if dir then cd
    if [ -d "$@" ]
    then
        \cd "$@"
    #if file then cd to parent dir
    else
        \cd ${1%/*}
    fi

    ls
}


### VCS setups ###
#aliases to make up for svn sucking monkey balls
alias svn_clean='svn status --no-ignore | grep "^\?" | sed "s/^\?      //"  | xargs -Ixx rm -rf xx'


### vim stuff
if [ ! -d /tmp/curtis ]; then
    mkdir /tmp/curtis/
fi
export EDITOR=vim

### MISC ###
LESS='-R'

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

alias tmux='tmux -2' #colors!


### COMMANDS ###
alias tweb='cd ~/code/m_m; tmux attach -d -t wcode || tmux new -s wcode'
alias tcode='cd ~/code/lib; tmux attach -d -t code || tmux new -s code'
alias tscript='cd ~/scripts; tmux attach -d -t script || tmux new -s script'
alias trtor='cd ~/; tmux attach -d -t rtor || tmux new -s rtor'

alias rnosql='sudo mongod --config /etc/mongodb.conf'
alias rweb='morbo Media/bin/start_web.pl daemon -w ./ -w ../templates'
source /usr/share/nvm/init-nvm.sh


linux_bash="$HOME/.ssh/service/ssh-agent"
if [ -e "$linux_bash" ];then
setsid "$linux_bash" 2>&1 & disown
fi

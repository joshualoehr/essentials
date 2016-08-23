# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Add django-debug-toolbar to Python path
# export PYTHONPATH="${PYTHONPATH}:/home/loehrj/django-debug-toolbar"

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# Set Oracle Home
export ORACLE_HOME=/usr/local/oracle/instantclient_11_2

# git authors alias function
alias gg='git status'
function git-whodidit() {
  NAMES=(
    "Josh Loehr" "34"
    "Edson Smith" "31"
    "Lauren Heller" "35"
    "Brent Carey" "32"
    "Wesley Van Komen" "33" 
    "Jessica Betts" "97"
  )
  CMDS=("git blame $1")
  count=0
  while [ "x${NAMES[count]}" != "x" ]
  do
      CMDS[$((count+1))]="| GREP_COLOR='01;${NAMES[$((count+1))]}' egrep --color=always -E '^|^.*${NAMES[count]}.*$'"
      count=$((count+2))
  done
  
  cmd=$(printf " %s" "${CMDS[@]}")
  cmd=${cmd:1}
  eval $cmd
}
alias gw='git-whodidit'

# some more ls aliases
alias ll='ls -la'
alias la='ls -A'
alias l='ls -CF'

#enable dir_colors
eval `dircolors ~/.dir_colors`
alias ls="ls --color=auto --ignore='*.pyc'"

topfive() {
    find . -type f -exec ls -s {} \; | sort -n -r | head -$1	
}

clsr() {
    clear
    ls -R    
}

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export WORKON_HOME=$HOME/.virtualenvs

function cd() {
    #gets the target location for the cd
    if [ -z "$@" ];
    then
        target=~
    else
        target=$@
    fi

    #sets the correct virtual environment based on current environment and cd path
    if [[ $target == *"django"* ]]
    then
        if [ !${VIRTUAL_ENV} ] || [ ${VIRTUAL_ENV} != 'django' ];
        then
            eval workon django
        fi
    fi

    if [[ $target == *"resnet"* ]]
    then
        if [ !${VIRTUAL_ENV} ] || [ ${VIRTUAL_ENV} != 'resnet' ];
        then
            eval workon resnet
        fi
    fi

    if [[ $target == *"data-api"* ]]
    then
        if [ !${VIRTUAL_ENV} ] || [ ${VIRTUAL_ENV} != 'data-api' ];
        then
            eval workon data-api
        fi
    fi

    if [[ $target == *"internal"* ]]
    then
        if [ !${VIRTUAL_ENV} ] || [ ${VIRTUAL_ENV} != 'internal' ];
        then
            eval workon internal
        fi
    fi

    if [[ $target == *"external"* ]]
    then
        if [ !${VIRTUAL_ENV} ] || [ ${VIRTUAL_ENV} != 'external' ];
        then
            eval workon external
        fi
    fi

    #runs cd with the args and calls ls
    builtin cd "$@" && ls;
}

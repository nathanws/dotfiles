# My AMAZING bashrc

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# COLORS -------------------------------------------------------------
black='\[\033[0;30m\]'
red='\[\033[0;31m\]'
RED='\[\033[1;31m\]'
green='\[\033[0;32m\]'
GREEN='\[\033[1;32m\]'
yellow='\[\033[0:33m\]'
YELLOW='\[\033[1;33m\]'
blue='\[\033[0;34m\]'
BLUE='\[\033[1;34m\]'
cyan='\[\033[0;36m\]'
CYAN='\[\033[1;36m\]'
NORMAL='\[\033[00m\]'


# General Settings ---------------------------------------------------

# Check window size after each command and, if necessary, update
# the values of LINES and COLUMNS
shopt -s checkwinsize

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Enable color support of ls, and some handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm/xterm-color|*-256color) color_prompt=yes;;
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

#if [ "$color_prompt" = yes ]; then
#    if [[ ${EUID} == 0 ]] ; then
#        PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\h\[\033[01;34m\] \W \$\[\033[00m\] '
#    else
#        PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\w \$\[\033[00m\] '
#    fi
#else
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h \w \$ '
#fi
#unset color_prompt force_color_prompt

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions, loads from there if available
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Load any other stuff if available
if [ -f ~/.other_stuff ]; then
    . ~/.other_stuff
fi


# History Settings ---------------------------------------------------

# Change location of history file
# HISTFILE=~/.new_file

export HISTFILESIZE=20000
export HISTSIZE=2000        # Keep X lines of history

# Append to the history file, instead of overwriting it
shopt -s histappend

# Combine multiline commands into one in the history
shopt -s cmdhist

HISTCONTROL=ignoreboth      # Combines ignorespace and ignoredups
# HISTCONTROL=ignoredups      # Ignore duplicates
# HISTCONTROL=ignorespace     # Ignore commands with leading whitespace
# HISTCONTROL=erasedups       # Erases duplicates from history

# Ignore ls la ll lll  without options, and other builtin commands
export HISTIGNORE='ls:la:ll:lll:[bf]g:exit:clear'

# Display timestamp
export HISTTIMEFORMAT='%F %T '


# Aliases ------------------------------------------------------------

# clear the terminal window
alias cls='clear'

# Define any OS specific stuff here
case "$(uname -s)" in

  # OSX
  Darwin)
   # Mainly used for OSX since rm permanently deletes
    alias del='rm -target-directory=$HOME/.Trash/'
    alias la='ls -A -G'
    alias ll='ls -l -G'
    alias lll='ls -lahG'
    alias ls='ls -G'
    alias l.='ls -dG .*'
  ;;

  Linux)
    alias la='ls -A -G --color=auto'
    alias ll='ls -l -G --color=auto'
    alias lll='ls -lah -G --color=auto'
    alias ls='ls -G --color=auto'
    alias l.='ls -d .* --color=auto'
  ;;

  # Windows
  CYGWIN*|MINGW32*|MSYS*)
  ;;

  # Anything else
  *)
  ;;
esac

# list only files in the current directory
alias lsf='ls -lahGp | grep -v /'

# list only directories in the current directory
alias lsd='ls -lahd */'

# Display size (sorted) of the folders in current directory
# alias folders='find . -maxdepth 1 -type d -print0 | xargs -0 du -sk | sort -rn'

# git stuff
alias gd='git diff'
alias gdn='git diff --name-only' # list only filenames of changes not staged for commit
alias gl='git log'
alias glo='git log --oneline'
alias gs='git status'
alias gshow='git show --name-only' # show what files were changed on the last commit
alias gi='git update-index --assume-unchanged'
alias gba='git branch -a'
alias gco='git checkout'
alias gsetupgh='git config user.email "nathanws@users.noreply.github.com" && git config user.name "Nathan"'
alias gsub='git submodule init && git submodule update'

# Quick way to serve files in HTTP from the current directory
alias webs='python -m SimpleHTTPServer'

# Becase I'm always editing these damn things
alias vrc='vim ~/.vimrc'
alias brc='vim ~/.bashrc'
alias src='source ~/.bash_profile'

# Because I'm lazy:
alias h='history'

# show a nice disk usage thing
alias usage='df -hT'

# FUNCTIONS ----------------------------------------------------------
# Does a very nice lll after a cd into a directory. Cause I'm lazy.
cdl () {
    cd "$@" && lll
}

# cds up the specified number of directories, default is 1
function up () {
    local arg=${1:-1};
    local dir=""
    while [ $arg -gt 0 ]; do
        dir="../$dir"
        arg=$(($arg - 1));
    done
    cd $dir #>&/dev/null
}

# Bastard child of up() and cdl()
function upl () {
    local arg=${1:-1};
    local dir=""
    while [ $arg -gt 0 ]; do
        dir="../$dir"
        arg=$(($arg - 1));
    done
    cdl $dir #>&/dev/null
}

# Make a directory and cd into it
mkcd() {
    mkdir -pv "$@" && cd "$@";
}

# List the file with the most recent timestamp
latest () {
    ls -lrt | tail -1
}

# remove all stupid temp files that I hate
clean () {
    rm *.url *.nzb *.sfv *.srr *.nfo
}

# search contents of files for a phrase
tsearch () {
    grep -rnw . -e "$1" $2
}

# lll grope
lgrope () {
    lll | grope "$@"
}

# Common rsync options that I use
alias rap='rsync -avh --progress'

# Common folders I often want to go to
# TODO: set these values in a separate config file
alias cdsrc='cdl ~/src'

# prints help stuff for my shorts
shorts () {
    echo "GENERAL NAVIGATION"
    echo "cdl   DIR     cd [DIR] && lll"
    echo "up    NUM     move up [NUM] directories, default is 1"
    echo "upl   NUM     move up [NUM] directories && lll"
    echo ""

    echo "DIRECTORY LISTINGS"
    echo "la     ls -A"
    echo "ll     ls -l"
    echo "lll    ls -lah"
    echo "lsf    show only files in current directory"
    echo "lsd    show only directories in current directory"
    echo "l.     ls -d .* (show only hidden files)"
    echo ""

    echo "DIRECTORY NAVIGATION"
    echo "cdsrc     cdl to my source code directory"
    echo ""

    echo "GIT"
    echo "gd       'git diff'"
    echo "gdn      'git diff --name-only', list only filenames of changes not staged for commit"
    echo "gl       'git log'"
    echo "glo      'git log --oneline'"
    echo "gs       'git status'"
    echo "gshow    'git show --name-only', show what files were changed on the last commit"
    echo "gba      'git branch -a'"
    echo "gco      'git checkout'"
    echo "gsetupgh configs the current git repo to use my github name/email"
    echo "gsub     'git submodule init && git submodule update'"
    echo ""

    echo "OTHER SHORTS"
    echo "clean         rm *.url *.nzb *.sfv *.srr *.nfo"
    echo "cls           clear the terminal screen"
    echo "del           send file to $HOME/.Trash (OSX only)"
    echo "grope         my special grep, 'grope -h' for options"
    echo "h             bash history, because I too lazy to type 'history'"
    echo "latest        list the file with the most recent timestamp"
    echo "lgrope TEXT   lll | grope [TEXT]"
    echo "mkcd   DIR    mkdir [DIR] && cd [DIR]"
    echo "rap    FILE   rsync -avh --progress [FILE]"
    echo "ren    FILE   replaces all spaces in the filename with periods, removes all parentheses and commas"
    echo "shorts        list this help dialog"
    echo "tsearch TEXT  search the contents of all files in the current directory for the specified TEXT"
    echo "usage         display a nice disk usage thing"
    echo "webs          quick way to serve files in HTTP from the current directory"
}

#-----------------------------------------------------------------------------
# Command prompt repo stuff
# Shows the current branch name if the current directory is a svn, mercurial, or git repo
function parse_git_branch {
    if [ -d .git ]
    then
        ref=$(git symbolic-ref HEAD 2> /dev/null) || return
        echo " (git::"${ref#refs/heads/}")"
    fi
}

function parse_hg_branch {
    if [ -d .hg ]
    then
        branch=$(hg branch 2> /dev/null) || return
        echo " (hg::"${branch}")"
    fi
}

parse_svn_branch() {
    if [ -f .svn/entries ]
    then
        parse_svn_url | sed -e 's#^'"$(parse_svn_repository_root)"'##g' | awk '{print " (svn::"$1")" }'
    fi
}
parse_svn_url() {
    cat .svn/entries | tail +5 | head -1
}
parse_svn_repository_root() {
    cat .svn/entries | tail +6 | head -1
}
# END repo stuff
#-----------------------------------------------------------------------------

# Exports ------------------------------------------------------------
export EDITOR=/usr/bin/vim

# Command prompt configs ---------------------------------------------
# \d = the date in "Weekday Month Date" (e.g. Fri Aug 26)
# \D{format} = the format is passed to strftime(3)
# \h = hostname up to first '.'
# \H = full hostname
# \t = the current time in 24 hour HH:MM:SS format
# \T = the current time in 12 hour HH:MM:SS format
# \@ = current time in 12 hour am/pm format
# \A = the current time in 12 hour HH:MM format
# \u = username
# \w = working directory
# \W = full path to working directory
# $? = last return code
# \\ = a backslash

export PS1="$cyan[\h]\W$green\$(parse_git_branch)\$(parse_hg_branch)$NORMAL $ "
# export PS1="$GREEN[\u@\h \W$YELLOW\$(parse_git_branch)\$(parse_hg_branch)\$(parse_svn_branch)$GREEN]\\$ "
# export PS1="$cyan\W$green\$(parse_git_branch)\$(parse_hg_branch)\$(parse_svn_branch)$NORMAL $ "
# export PS1="$cyan\W$green\$(parse_git_branch)\$(parse_hg_branch)$NORMAL $ "
# PS1="\n[\u@\h]: \w\n$?>"


# PATH Stuff

# add scripts
PATH=$PATH:$HOME/src/mine/dotfiles/bin

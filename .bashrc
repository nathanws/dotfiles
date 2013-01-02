# My AMAZING bashrc

# If not running interactively, don't do anything
[ -z "$PS1" ] && return


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

# Alias definitions, loads from there if available
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
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
alias la='ls -A'
alias ll='ls -l'
alias lll='ls -lah'
# alias ls='ls -G'

# Mainly used for OSX since rm permanently deletes
alias del='rm -target-directory=$HOME/.Trash/'

# Display size (sorted) of the folders in current directory
alias folders='find . -maxdepth 1 -type d -print0 | xargs -0 du -sk | sort -rn'

# git stuff
alias gs='git status'
alias gl='git log'
alias glo='git log --oneline'

# Quick way to serve files in HTTP from the current directory
alias webs='python -m SimpleHTTPServer'

# Becase I'm always editing these damn things
alias vrc='vim ~/.vimrc'
alias brc='vim ~/.bashrc'
alias src='source ~/.bashrc && source ~/.vimrc'

# Because I'm lazy:
alias h='history'

# show a nice disk usage thing
alias usage='df -hT'


# FUNCTIONS ----------------------------------------------------------
# cds up the number of directories passed in (e.g., up 3), default is 1
function up () {
    local arg=${1:-1};
    local dir=""
    while [ $arg -gt 0 ]; do
        dir="../$dir"
        arg=$(($arg - 1));
    done
    cd $dir #>&/dev/null
} 

# Does a very nice lll after a cd into a directory. Cause I'm lazy.
cdl () {
    cd "$@" && lll 
}

# Backups a file, super handy
bu() {
    cp $1 `basename $1`_`date +%Y%m%d%H%M`.bak ;
}

# Make a directory and cd into it
mkcd() {
    mkdir -pv "$@" && cd "$@";
}

# List the file with the most recent timestamp
latest () {
    ls -lrt | tail -1
}

# replaces all spaces in the filename with periods
# BECAUSE I HATE SPACES IN FILE NAMES
rep () {
    rename 's/ /./g' "$@"
}

# Memorizing tar syntax and other junk is too annoying
extract() {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)  tar xjf $1      ;;
            *.tar.gz)   tar xzf $1      ;;
            *.bz2)      bunzip2 $1      ;;
            *.rar)      rar x $1        ;;
            *.gz)       gunzip $1       ;;
            *.tar)      tar xf $1       ;;
            *.tbz2)     tar xjf $1      ;;
            *.tgz)      tar xzf $1      ;;
            *.zip)      unzip $1        ;;
            *.Z)        uncompress $1   ;;
            *)  echo "'$1' cannot be extracted via extract() (function from bashrc)";;
        esac
    else
        echo "'$1' is not a valid file"
    fi
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

# Exports ------------------------------------------------------------
export EDITOR=/usr/bin/vim

# PATH Stuff
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

export PHABRICATOR_ENV=custom/myconfig

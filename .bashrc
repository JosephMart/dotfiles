#-------------------------------------------------------------------------

# OS Detection names
# if [[ "$OSTYPE" == $type_NAME ]]; then
# ...
# fi

# Good ol Linux GNU
export type_LINUX="linux-gnu"

# MAC
export type_MAC="darwin"*

# POSIX compatibility layer and Linux environment emulation for Windows
export type_CYGWIN="cygwin"

 # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
export type_MSYS="msys"

# I'm not sure this can happen.
export type_WIN32"win32"

export type_FREEBSD="freebsd"*

#-------------------------------------------------------------------------

# Prompt

export PS1='\[$(tput setaf 6)\]$(tput bold)┌── \[$(tput setaf 76)\][\u@\h] \[$(tput setaf 214)\][\w]\[$(tput setaf 6)\]$(__git_ps1 " [%s]")\n\[$(tput setaf 6)\]\[$(tput bold)\]└──$ \[$(tput sgr0)\]'
export PS2='\[$(tput setaf 6)\]$(tput bold)└──$ \[$(tput sgr0)\]'
export PS3='\[$(tput setaf 6)\]$(tput bold)└──$ \[$(tput sgr0)\]'
export PS4='\[$(tput setaf 6)\]$(tput bold)└──$ \[$(tput sgr0)\]'

# How many directories to show
PROMPT_DIRTRIM=3

#-------------------------------------------------------------------------

# Tab completion

# Check for interactive bash and that we haven't already been sourced.
if [ -n "${BASH_VERSION-}" -a -n "${PS1-}" -a -z "${BASH_COMPLETION_COMPAT_DIR-}" ]; then
    # Check for recent enough version of bash.
    if [ ${BASH_VERSINFO[0]} -gt 4 ] || \
       [ ${BASH_VERSINFO[0]} -eq 4 -a ${BASH_VERSINFO[1]} -ge 1 ]; then
        [ -r "${XDG_CONFIG_HOME:-$HOME/.config}/bash_completion" ] && \
            . "${XDG_CONFIG_HOME:-$HOME/.config}/bash_completion"
        if shopt -q progcomp && [ -r /usr/share/bash-completion/bash_completion ]; then
            # Source completion code.
            . /usr/share/bash-completion/bash_completion
        fi
    fi
fi

# Tab completion for Mac
if [[ "$OSTYPE" == $type_MAC ]]; then
    if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
    fi
fi

#-------------------------------------------------------------------------

# Tab Completion Boost

bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'
bind '"\e[Z":menu-complete-backward' # Shift tab
bind "set menu-complete-display-prefix on"
bind "set completion-ignore-case on"
bind "set bell-style none"
bind "set skip-completed-text on"


#-------------------------------------------------------------------------

# Git branch for prompt

source ~/.git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1

#-------------------------------------------------------------------------

# Solus default .bashrc location

# source /usr/share/defaults/etc/profile

#-------------------------------------------------------------------------

# Line to add to OS .bashrc file

# source $HOME/joseph/dotfiles/.bashrc

#-------------------------------------------------------------------------

# Add GPG

export GPG_TTY=$(tty)

# ------------------------------------------------------------------------

# Golang

export GOPATH=$HOME/projects/go
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

#------------------------------------------------------------------------

# Pipenv

if hash pipenv 2>/dev/null; then
    eval "$(pipenv --completion)"
    alias prp="pipenv run python"
fi


#-----------------------------------------------------------------------

# AWS Box

export boxip="18.219.190.156"
alias sshbox="ssh -i $HOME/.ssh/joseph-box-key.pem ubuntu@$boxip"
alias scpbox="scp -i $HOME/.ssh/joseph-box-key.pem"

#-----------------------------------------------------------------------

# Direnv

if type "direnv" > /dev/null 2>&1; then
    eval "$(direnv hook bash)"
fi

#-----------------------------------------------------------------------

# Colorize ls

if [[ "$OSTYPE" == $type_MAC ]]; then
    export CLICOLOR=1
    export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
fi

if [[ "$OSTYPE" == $type_LINUX ]]; then
    alias ls='ls --color'
    export LS_COLORS=$LS_COLORS:'di=1:ex=4:ow=1:'
fi

#-----------------------------------------------------------------------

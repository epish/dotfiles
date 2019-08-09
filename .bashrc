export EDITOR="vim"
set -o vi

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

if [ "$(uname)" == "Darwin" ]; then
    # Do something under Mac OS X platform
    :
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    # Do something under GNU/Linux platform
    # remaps Caps_Lock key to a second Escape; on mac remap via GUI
    xmodmap -e "remove lock = Caps_Lock" 2> /dev/null
    xmodmap -e "keysym Caps_Lock = Escape" 2> /dev/null
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
    echo If this clause is non-empty - consider me dead
fi

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

for i in ~/completion/*; do
    #echo "loading $i"
	. $i
done


# custom functions
if [ -f ${HOME}/.bash/functions ]; then
	. ${HOME}/.bash/functions
fi

# custom functions
if [ -f ${HOME}/.bash/aliases ]; then
	. ${HOME}/.bash/aliases
fi

# aws config environs
if [ -f ${HOME}/.aws/config.sh ]; then
	. ${HOME}/.aws/config.sh
fi


# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoredups:erasedups

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


#setup color scheme for ls
if [ -f ~/.bash/lscolorscheme.sh ]; then
    . ~/.bash/lscolorscheme.sh
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  elif [ -r /usr/local/etc/profile.d/bash_completion.sh ]; then
    export BASH_COMPLETION_COMPAT_DIR=/usr/local/etc/bash_completion.d
    . /usr/local/etc/profile.d/bash_completion.sh
  fi
fi

export PATH="$PATH:${HOME}/bin/"
export GOPATH="$HOME/repos/go"
export GOROOT="/usr/local/go"
export PATH="$PATH:/usr/local/go/bin:$GOPATH/bin"
export PATH="$PATH:${HOME}/.composer/vendor/bin/"

## stuff for poweline
if [ "$(uname)" == "Darwin" ]; then
  PYTHON_PATH=$HOME/Library/Python/2.7
  if [ -r $PYTHON_PATH/lib/python/site-packages/powerline/bindings/bash/powerline.sh ]; then
    export PATH=$PATH:$PYTHON_PATH/bin
    powerline-daemon -q
    export POWERLINE_BASH_CONTINUATION=1
    export POWERLINE_BASH_SELECT=1
    export RENDER_POWERLINE_KUBERNETES="NO"
    . $PYTHON_PATH/lib/python/site-packages/powerline/bindings/bash/powerline.sh
  fi
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  if [ -f /usr/share/powerline/bindings/bash/powerline.sh ]; then
    powerline-daemon -q
    export POWERLINE_BASH_CONTINUATION=1
    export POWERLINE_BASH_SELECT=1
    export RENDER_POWERLINE_KUBERNETES="NO"
    . /usr/share/powerline/bindings/bash/powerline.sh
  fi
fi

### Init/reuse ssh-agent
ssh-add -l &>/dev/null
if [ "$?" != 0 ]; then
  #echo "agent is not running"
  test -r ~/.ssh-agent && eval "$(<~/.ssh-agent)" >/dev/null

  ssh-add -l &>/dev/null
  if [ "$?" != 0 ]; then
    echo "agent is STILL not running"
    (umask 066; ssh-agent > ~/.ssh-agent)
    eval "$(<~/.ssh-agent)" >/dev/null
    [[ -r $HOME/.ssh/id_rsa ]] && ssh-add $HOME/.ssh/id_rsa
  fi
fi

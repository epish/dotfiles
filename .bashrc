export EDITOR="vim"
set -o vi

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export CLICOLOR=1

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

complete -C /usr/local/bin/terraform terraform

export PATH="$PATH:${HOME}/bin/"
export GOPATH="$HOME/go"
#export GOROOT="/usr/local/go"
export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:${HOME}/.composer/vendor/bin/"
#export PATH="/usr/local/opt/terraform@0.13/bin:$PATH"



function _update_ps1() {
  local __ERRCODE=$?
  export PWL_PARAMS=" -colorize-hostname -shorten-gke-names"
  export PWL_MODULES="nix-shell,venv,ssh,cwd,perms,git,jobs,exit,root,vgo"
  [ -n "${KUBE_PWL_ENABLED}" ] && PWL_MODULES="$PWL_MODULES,kube"
  [ -n "${TF_PWL_ENABLED}" ] && PWL_MODULES="$PWL_MODULES,terraform-workspace"
  PS1="$(/usr/local/bin/powerline-go $PWL_PARAMS -modules $PWL_MODULES -error $__ERRCODE -shell bash)"
}

if [ "$TERM" != "linux" ] && [ -f "/usr/local/bin/powerline-go" ]; then
    PROMPT_COMMAND="_update_ps1;"
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
export LS_COLORS=no=00;#;normal:fi=00;#;file:di=01;94;#;directory:ln=01;36;#;link:pi=40;33;#;pipe:so=00;35;#:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=01;32;#;executable:*.cmd=00;32:*.exe=00;32:*.gz=44:*.bz2=44:*.bz=44:*.tz=44:*.rpm=44:*.deb=31:*.rar=44:*.zip=44:*.iso=44:*.cpio=00;31:*.c=33:*.h=33:*.sh=33:*.t=33:*.pm=33:*.pl=33:*.cgi=33:*.pod=33:*.PL=33:*.js=33:*.php=33:*.off=90;9:*.bak=90;9:*.old=90;9:*.swp=90;9:*.swo=90;9:*.htm=94:*.html=94:*.txt=94:*.text=94:*.css=94:*.avi=96:*.wmv=96:*.mpeg=96:*.mpg=96:*.mov=96:*.AVI=96:*.WMV=96:*.mkv=96:*.mp3=35:*.flac=35:*.wav=35:*.aac=35:*.jpg=96:*.jpeg=96:*.png=96:*.xcf=96:*.JPG=96:*.gif=96:*.svg=96:*.eps=00;96:*.pdf=00;96:*.PDF=00;96:*.ps=00;96:*.ai=00;91;#;adobe;ill:*.doc=00;91;#;msword;shit:*.csv=95:*.dsv=95:*.db=95:*.sql=95:*.meta=95:*.xml=95:*.yaml=95:*.yml=95:*.conf=95:



export EDITOR="vim"
set -o vi

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

for i in ~/completion/*; do
	. $i
done


# custom functions
if [ -f /home/${USER}/.bash/functions ]; then
	. /home/${USER}/.bash/functions
fi

# custom functions
if [ -f /home/${USER}/.bash/aliases ]; then
	. /home/${USER}/.bash/aliases
fi


export PATH=$PATH":/home/${USER}/bin/"

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
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

base_color='\[\e[0m\]'
COL_delim='\[\e[0;37m\]'
COL_user='\[\e[0;94m\]'
COL_warn='\[\e[0;31m\]'
COL_host='\[\e[0;96m\]'
COL_pwd='\[\e[0;32m\]'
COL_hist='\[\e[0;93m\]'
delim1='\342\224\200'

PS1="${COL_delim}\342\224\214$delim1\$([[ \$? != 0 ]] && echo \"[${COL_warn}\342\234\227${COL_delim}]$delim1\")[$(if [[ ${EUID} == 0 ]]; then echo '${COL_warn}\h'; else echo "${COL_user}\u${COL_delim}@$COL_host\h"; fi)${COL_delim}]$delim1[${COL_pwd}\w${COL_delim}]\n${COL_delim}\342\224\224$delim1$delim1${COL_hist}[\!]${COL_delim}\342\225\274 ${base_color}"


TERM=screen-256color


# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


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
  fi
fi

#Better Console Calculator Using bc
function calc
{
  echo "${1}" | bc -l;
}


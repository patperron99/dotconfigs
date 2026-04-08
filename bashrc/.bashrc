# Load environment variables from .env file
if [ -f ~/.env ]; then
    export $(cat ~/.env | xargs)
fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

stty -ixon # Disables ctrl-s and ctrl-q (Used To Pause Term)

# Aliases
alias ls='ls --color=auto'
alias wallpaper='sudo cp ~/.config/backgrounds/default /usr/share/wallpapers/'
alias ll='ls -al --color=auto'
alias df='df -h'
alias free='free -h'
alias myip="ip -f inet address | grep inet | grep -v 'lo$' | cut -d ' ' -f 6,13 && curl ifconfig.me && echo ' external ip'"
alias x="exit"
# Dotfiles & Files
alias reload='source ~/.bashrc'
# Git aliases
alias gp="git push -u origin main"
alias gsave="git commit -m 'save'"
alias gs="git status"
alias gc="git clone"
alias ff="fastfetch"
alias code="codium"
alias kick=tmux_ssh
alias v=tmux_nvim

alias egrep='grep --color=auto'

export PATH="~/scripts:$PATH"
export PATH="~/.local/bin:$PATH"
export PATH="/usr/local/go/bin:$PATH"
export VISUAL=nvim
export EDITOR=nvim
export PATH="$PATH:/opt/nvim-linux64/bin"
export PATH="$PATH:/home/sysadmin/go/bin"

# Nord Colors
POLAR_NIGHT_0='\[\e[38;2;46;52;64m\]'
POLAR_NIGHT_1='\[\e[38;2;59;66;82m\]'
POLAR_NIGHT_2='\[\e[38;2;67;76;94m\]'
POLAR_NIGHT_3='\[\e[38;2;76;86;106m\]'
SNOW_STORM_0='\[\e[38;2;216;222;233m\]'
SNOW_STORM_1='\[\e[38;2;229;233;240m\]'
SNOW_STORM_2='\[\e[38;2;236;239;244m\]'
FROST_0='\[\e[38;2;143;188;187m\]'
FROST_1='\[\e[38;2;136;192;208m\]'
FROST_2='\[\e[38;2;129;161;193m\]'
FROST_3='\[\e[38;2;94;129;172m\]'
AURORA_RED='\[\e[38;2;211;134;155m\]'
AURORA_ORANGE='\[\e[38;2;235;137;91m\]'
AURORA_YELLOW='\[\e[38;2;235;174;97m\]'
AURORA_GREEN='\[\e[38;2;197;232;178m\]'
AURORA_PURPLE='\[\e[38;2;191;97;106m\]'
AURORA_BLUE='\[\e[38;2;116;185;255m\]'
RESET='\[\e[0m\]'

# Special characters for powerline-style segments
SEPARATOR=""
BRANCH=""
PYTHON=""
ERROR="✗"
OK="✓"

# Function to get Git branch
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

# Function to get Python virtual environment
get_virtual_env() {
    if [ -n "$VIRTUAL_ENV" ]; then
        echo $(basename $VIRTUAL_ENV)
    fi
}

# Function to set the prompt
set_prompt() {
    # Get the exit code of last command
    local EXIT="$?"

    # First line
    PS1="\n${AURORA_BLUE}┌─${RESET}"

    # User and host
    PS1+="${AURORA_PURPLE}\u${SNOW_STORM_2}@${FROST_2}\h${RESET}"
    PS1+="${AURORA_BLUE} ${SEPARATOR}${RESET}"

    # Current directory
    PS1+="${AURORA_GREEN} \w${RESET}"

    # Git branch if in a git repository
    if git rev-parse --git-dir > /dev/null 2>&1; then
        PS1+="${AURORA_BLUE} ${SEPARATOR}${RESET}"
        PS1+="${AURORA_ORANGE} ${BRANCH} $(parse_git_branch)${RESET}"
    fi

    # Python virtual environment if active
    if [ -n "$(get_virtual_env)" ]; then
        PS1+="${AURORA_BLUE} ${SEPARATOR}${RESET}"
        PS1+="${AURORA_YELLOW} ${PYTHON} $(get_virtual_env)${RESET}"
    fi

    # Exit status of previous command
    PS1+="${AURORA_BLUE} ${SEPARATOR}${RESET}"
    if [ $EXIT != 0 ]; then
        PS1+="${AURORA_RED} ${ERROR} ${EXIT}${RESET}"
    else
        PS1+="${AURORA_GREEN} ${OK}${RESET}"
    fi

    # Second line
    PS1+="\n${AURORA_BLUE}└─${RESET}"

    # Prompt character
    PS1+="${AURORA_BLUE}❯${RESET} "
}

# Set up prompt command
PROMPT_COMMAND=set_prompt

tmux_ssh() {
  if [[ -z $1 ]]; then
    tab_name=$(basename $(pwd))
  else
    tab_name=$(basename "$1")
  fi
  session="ssh-session"
  tmux has-session -t $session 2>/dev/null
  if [ $? != 0 ]; then
    tmux new-session -d -s ssh-session
  fi
  tmux new-window -t ssh-session -n "$tab_name" "ssh $1"
  tmux attach-session -t ssh-session
}
# tmux
tmux_nvim() {
  if [[ -z $1 ]]; then
    tab_name=$(basename $(pwd))
  else
    tab_name=$(basename "$1")
  fi
  session="neovim-session"
  tmux has-session -t $session 2>/dev/null
  if [ $? != 0 ]; then
    tmux new-session -d -s neovim-session
  fi
  tmux new-window -t neovim-session -n "$tab_name" "OPENAI_API_KEY=\"$OPENAI_API_KEY\" nvim $1"
  tmux attach-session -t neovim-session
}

# PS1="${PURPLE}\u${RESET}@${SKY}\h ${PINK}\w${YELLOW} \$(parse_git_branch)${RESET}\n${GREEN}➜ ${RESET}"

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

. "$HOME/.local/bin/env"

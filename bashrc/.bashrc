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

# Catppuccin Colors
ROSEWATER='\[\e[38;2;245;224;220m\]'
FLAMINGO='\[\e[38;2;242;205;205m\]'
PINK='\[\e[38;2;245;194;231m\]'
MAUVE='\[\e[38;2;203;166;247m\]'
RED='\[\e[38;2;243;139;168m\]'
MAROON='\[\e[38;2;235;160;172m\]'
PEACH='\[\e[38;2;250;179;135m\]'
YELLOW='\[\e[38;2;249;226;175m\]'
GREEN='\[\e[38;2;166;227;161m\]'
TEAL='\[\e[38;2;148;226;213m\]'
BLUE='\[\e[38;2;137;180;250m\]'
LAVENDER='\[\e[38;2;180;190;254m\]'
TEXT='\[\e[38;2;205;214;244m\]'
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
    PS1="\n${BLUE}┌─${RESET}"
    
    # User and host
    PS1+="${MAUVE}\u${TEXT}@${LAVENDER}\h${RESET}"
    PS1+="${BLUE} ${SEPARATOR}${RESET}"
    
    # Current directory
    PS1+="${GREEN} \w${RESET}"
    
    # Git branch if in a git repository
    if git rev-parse --git-dir > /dev/null 2>&1; then
        PS1+="${BLUE} ${SEPARATOR}${RESET}"
        PS1+="${PEACH} ${BRANCH} $(parse_git_branch)${RESET}"
    fi
    
    # Python virtual environment if active
    if [ -n "$(get_virtual_env)" ]; then
        PS1+="${BLUE} ${SEPARATOR}${RESET}"
        PS1+="${YELLOW} ${PYTHON} $(get_virtual_env)${RESET}"
    fi
    
    # Exit status of previous command
    PS1+="${BLUE} ${SEPARATOR}${RESET}"
    if [ $EXIT != 0 ]; then
        PS1+="${RED} ${ERROR} ${EXIT}${RESET}"
    else
        PS1+="${GREEN} ${OK}${RESET}"
    fi
    
    # Second line
    PS1+="\n${BLUE}└─${RESET}"
    
    # Prompt character
    PS1+="${BLUE}❯${RESET} "
}

# Set up prompt command
PROMPT_COMMAND=set_prompt
# # Custom Catppuccin two-line prompt
# RESET="\[\e[0m\]"
# PURPLE="\[\e[38;5;140m\]"
# PINK="\[\e[38;5;212m\]"
# CYAN="\[\e[38;5;37m\]"
# GREEN="\[\e[38;5;107m\]"
# YELLOW="\[\e[38;5;214m\]"
# SKY="\[\e[38;5;74m\]"
# parse_git_branch() {
#   branch=$(git branch 2>/dev/null | grep '*' | sed 's/* //')
#   if [[ -n "$branch" ]]; then
#     echo "[$(git branch 2>/dev/null | grep '*' | sed 's/* //')]"
#   fi
# }

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
  tmux new-window -t neovim-session -n "$tab_name" "nvim $1"
  tmux attach-session -t neovim-session 
}

PS1="${PURPLE}\u${RESET}@${SKY}\h ${PINK}\w${YELLOW} \$(parse_git_branch)${RESET}\n${GREEN}➜ ${RESET}"

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


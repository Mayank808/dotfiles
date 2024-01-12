# Set XDG_CONFIG_HOME to organize user configuration files
export XDG_CONFIG_HOME="$HOME/.config"

# Set ZDOTDIR to specify the directory for Zsh configuration files
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export PATH="$HOME/bin:$PATH"

# Load the Zsh profile
source $ZDOTDIR/.zshprofile

# Load the Zshrc file
source $ZDOTDIR/.zshrc

# Add support for UTF-8 to the terminal
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

HISTFILE="$XDG_DATA_HOME/zsh/.zsh_history"
HISTSIZE=1000
SAVEHIST=1000

export BROWSER="google-chrome"
export VISUAL="code"
export EDITOR="$VISUAL"
export PAGER="bat"
export MANPAGER='bat'
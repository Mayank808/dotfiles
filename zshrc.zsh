# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/mayank/miniconda3/bin/conda' 'shell.zsh' 'hook' 2>/dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/mayank/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/mayank/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/mayank/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

if command -v brew &>/dev/null; then
    # eval "$(rtx activate zsh)"
    
    # Adds syntax highlighting from plugin
    ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=$(brew --prefix)/share/zsh-syntax-highlighting/highlighters
    source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

    # Adds auto suggestions to terminals
    source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

    # Add powerlevel10k theme
    # source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme

    autoload -Uz compinit
    compinit
    zstyle ':completion:*' menu select

    if type brew &>/dev/null; then
        FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

        autoload -Uz compinit
        compinit
    fi

    fortune | cowsay -f eyes
fi

source "$ZDOTDIR/.prompt.zsh"
source "$ZDOTDIR/.aliases.zsh"

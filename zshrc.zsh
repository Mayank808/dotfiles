# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
conda_path="/Users/mayank/miniconda3"
__conda_setup="$('${conda_path}/bin/conda' 'shell.zsh' 'hook' 2>/dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "${conda_path}/etc/profile.d/conda.sh" ]; then
        . "${conda_path}/etc/profile.d/conda.sh"
    else
        export PATH="${conda_path}/bin:$PATH"
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

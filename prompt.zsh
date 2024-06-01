if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
    if test "$(oh-my-posh)"; then
        eval "$(oh-my-posh init zsh --config ~/Developer/dotfiles/themes/.promptTheme.omp.json)"
    fi
fi
if command -v fzf >/dev/null; then
  #export FZF_DEFAULT_COMMAND='fd --type f'
  #export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  #export FZF_ALT_C_COMMAND='fd --type d'
  source <(fzf --zsh)
fi

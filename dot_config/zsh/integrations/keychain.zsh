if command -v keychain >/dev/null; then
  eval "$(keychain --eval --quiet github)"
fi

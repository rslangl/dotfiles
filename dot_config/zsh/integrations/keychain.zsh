if command -v keychain >/dev/null; then
  eval "$(keychain --absolute --dir $XDG_RUNTIME/keychain --eval github)"
fi

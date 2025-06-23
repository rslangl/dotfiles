# dotfiles

Install chezmoi:
```shell
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin
```

Install dots:
```shell
chezmoi init https://github.com/rslangl/dotfiles.git
```

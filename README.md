# dotfiles

Install chezmoi:
```shell
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin
```

Install dots (prime `sudo` before executing):
```shell
sudo -v
chezmoi init https://github.com/rslangl/dotfiles.git
```

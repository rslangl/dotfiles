# dotfiles

## Fresh install on barebones Debian 12

Install sudo and add myself
```shell
su 
apt install sudo usermod
/usr/sbin/usermod -a -G sudo rune
su rune
```

Install tools to actually configure the system
```shell
sudo apt install git
```

Get the dotfiles repository and deploy configurations
```shell
git clone https://github.com/rslangl/dotfiles $HOME/.dotfiles
cd $HOME/.dotfiles
./install
```

Install and configure X
```shell
sudo apt xorg
TODO: whut? Xorg -configure or nvidia-xconfig?
```

Install and configure NVIDIA driver
```shell
sudo apt install linux-headers-amd64
sudo sed -i '/^deb http:\/\/deb.debian.org\/debian\/ bookworm main non-free-firmware contrib/ s/$/ non-free-firmware/' /etc/apt/sources.list
sudo apt update
sudo apt install nvidia-driver firmware-misc-nonfree
su
echo 'GRUB_CMDLINE_LINUX="$GRUB_CMDLINE_LINUX nvidia-drm.modeset=1"' > /etc/default/grub.d/nvidia-modeset.cfg
update-grub
su rune
sudo reboot now
```

Create xorg configuration using `nvidia-xconfig` (will create `/etc/X11/xorg.conf`)
```shell
sudo apt install nvidia-xconfig
sudo nvidia-xconfig 
```

Install and configure i3
```shell
sudo apt install i3
TODO: how to ensure config symlink is not replaced
```

Install and configure zsh and oh-my-zsh
```shell
sudo apt install zsh
sudo usermod --shell /bin/zsh rune
curl -fsSL -o $HOME/Downloads https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh 
ZSH=$HOME/.config/zsh/ohmyzsh sh $HOME/Downloads/install.sh
```

Install various utilities
```shell

```

Reboot and do something that is actually productive

## References

* [XDG base directory](https://wiki.archlinux.org/title/XDG_Base_Directory)
* [Zsh](https://wiki.debian.org/Zsh)
* [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh)
* [NvidiaGraphicsDriver](https://wiki.debian.org/NvidiaGraphicsDrivers)
* [NvidiaGraphicsDriver: Configuration](https://wiki.debian.org/NvidiaGraphicsDrivers/Configuration)

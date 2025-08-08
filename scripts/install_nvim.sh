#!/bin/bash
set -e

echo "-- NeoVim 0.9.1 or above not found, installing latest for you."

cd "$(dirname $0)/.."

install_snap() {
    if ! which apt >/dev/null 2>&1; then
        export DEBIAN_FRONTEND=noninteractive
        sudo apt update -y || true
        sudo apt install -y snapd || true
    elif ! which zypper >/dev/null 2>&1; then
        sudo zypper in --no-confirm snapd || true
    elif ! which dnf >/dev/null 2>&1; then
        sudo dnf install -y epel-release || true
        sudo dnf upgrade || true
        sudo dnf install -y snapd || true
    elif ! which yum >/dev/null 2>&1; then
        sudo yum install -y epel-release || true
        sudo yum install -y snapd || true
    fi
    sudo systemctl enable --now snapd || true
}

fix_nvim_appimage() {
    sudo mv /usr/bin/nvim /usr/bin/.nvim.appimage.noextract
    echo 'x=$$; mkdir -p /tmp/_nvim_appimg_.$x && bash -c "cd /tmp/_nvim_appimg_.$x && /usr/bin/.nvim.appimage.noextract --appimage-extract > /dev/null 2>&1" && /tmp/_nvim_appimg_.$x/squashfs-root/AppRun "$@"; y=$?; rm -rf /tmp/_nvim_appimg_.$x exit $y' | sudo tee /usr/bin/nvim
    sudo chmod +x /usr/bin/nvim
    # echo exec \"\$@\" > /bin/sudo; chmod +x /bin/sudo
}

if [ "x$(uname -sm)" = "xLinux x86_64" ]; then
    if which snap >/dev/null 2>&1; then
        sudo snap remove nvim || true
    fi
    test -f ./nvim.appimage || curl -SL https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage -o ./nvim.appimage
    sudo chmod +x ./nvim.appimage
    test -f /usr/bin/nvim && sudo mv /usr/bin/nvim /tmp/.nvim-executable-backup || true
    sudo cp ./nvim.appimage /usr/bin/nvim
    /usr/bin/nvim --version || fix_nvim_appimage
elif [ "x$(uname -sm)" = "xLinux aarch64" ]; then
    if which snap >/dev/null 2>&1; then
        sudo snap remove nvim || true
    fi
    curl -SL https://github.com/neovim/neovim/releases/latest/download/nvim-linux-arm64.appimage -o ~/.config/nvim/nvim.appimage
    sudo chmod +x ./nvim.appimage
    test -f /usr/bin/nvim && sudo mv /usr/bin/nvim /tmp/.nvim-executable-backup || true
    sudo cp ./nvim.appimage /usr/bin/nvim
    /usr/bin/nvim --version || fix_nvim_appimage
elif [ "x$(uname -s)" = "xDarwin" ]; then
    echo "-- MacOS detected, try installing latest nvim from brew..."
    brew uninstall neovim 2> /dev/null || true
    brew install neovim
else
    if which pacman >/dev/null 2>&1; then
      echo "-- Installing latest nvim with pacman..."
      pacman -S --noconfirm neovim
    else
      echo "-- Non x86_64 Linux detected, trying installing latest nvim from snap..."
      if ! which snap >/dev/null 2>&1; then
          echo "-- Snap not found, try installing for you..."
          install_snap
      fi
      sudo snap install nvim
    fi
fi


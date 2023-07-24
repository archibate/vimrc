set -e
cd "$(dirname "$0")"
# test -d /tmp/archvim-build/predownload || ARCHVIM_PREDOWNLOAD_MODE=2 nvim -c 'q'
nvim --cmd 'let g:archvim_predownload=2' -c 'q'
git --version > /dev/null
rm -rf /tmp/archvim-release
mkdir -p /tmp/archvim-release
cp -r ./lua ./init.vim /tmp/archvim-release
sed -i "s/\"let g:archvim_predownload=1/let g:archvim_predownload=1/" /tmp/archvim-release/init.vim
rm -rf /tmp/archvim-release/lua/archvim/predownload
cp -r /tmp/archvim-build/predownload /tmp/archvim-release/lua/archvim
rm -rf /tmp/archvim-release.tar.gz
cd /tmp/archvim-release
test -f /tmp/archvim-nvim.appimage || curl -L https://github.com/neovim/neovim/releases/latest/download/nvim.appimage -o /tmp/archvim-nvim.appimage
cp /tmp/archvim-nvim.appimage nvim.appimage
chmod u+x nvim.appimage
tar -zcvf /tmp/archvim-release.tar.gz .
cd "$(dirname "$0")"
rm -rf /tmp/archvim-release

payload=/tmp/archvim-release.tar.gz
script=/tmp/nvimrc-install.sh
# https://stackoverflow.com/questions/29418050/package-tar-gz-into-a-shell-script
printf "#!/bin/bash
set -e
sudo --version > /dev/null 2> /dev/null && SUDO=sudo || SUDO=
base64 --version > /dev/null
tar --version > /dev/null
rm -rf /tmp/_extract_.\$\$ /tmp/_extract_.\$\$.tar
mkdir -p /tmp/_extract_.\$\$
cat > /tmp/_extract_.\$\$.tar.gz.b64 << __VIMRC_PAYLOAD_EOF__\n" > "$script"

base64 "$payload" >> "$script"

printf "\n__VIMRC_PAYLOAD_EOF__
cd /tmp/_extract_.\$\$
base64 -d /tmp/_extract_.\$\$.tar.gz.b64 | tar -zxv
fix_nvim_appimage() {
    \$SUDO mv /usr/bin/nvim /usr/bin/nvim.appimage.noextract
    echo 'oldpwd=\$PWD; x=\$\$; mkdir -p /tmp/_nvim_appimg_.\$x && cd /tmp/_nvim_appimg_.\$x && (/usr/bin/nvim.appimage.noextract --appimage-extract && cd \"\$oldpwd\" > /dev/null 2>&1) && /tmp/_nvim_appimg_.\$x/squashfs-root/AppRun \"\$@\"; x=\$?; rm -rf /tmp/_nvim_appimg_.\$x exit \$x' | \$SUDO tee /usr/bin/nvim
    chmod u+x /usr/bin/nvim
}
install_nvim() {
    echo \"NeoVim 0.8.0 or above not found, installing latest for you\"
    test -f ./nvim.appimage || curl -L https://github.com/neovim/neovim/releases/latest/download/nvim.appimage -o ~/.config/nvim/nvim.appimage
    chmod u+x ./nvim.appimage
    test -f /usr/bin/nvim && \$SUDO mv /usr/bin/nvim /tmp/.nvim-executable-backup
    \$SUDO cp ./nvim.appimage /usr/bin/nvim
    nvim --version || fix_nvim_appimage
}
(nvim --version && [ \"1\$(nvim --version | head -n1 | cut -f2 -dv | sed s/\\.//g)\" -ge 1080 ]) || install_nvim
nvim --version
test -d ~/.config/nvim && mv ~/.config/nvim ~/.config/.nvim.backup.\$\$
mkdir -p ~/.config
rm -rf ~/.config/nvim
cp -r . ~/.config/nvim
# \$SUDO bash ~/.config/nvim/install_deps.sh
# rm -rf ~/.local/share/nvim/site/pack/packer
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerClean'
rm -rf /tmp/_extract_.\$\$ /tmp/_extract_.\$\$.tar.gz.b64
echo \"-- OK, installed into ~/.config/nvim, now run 'nvim' to play\"
\n" >> "$script"

rm "$payload"
chmod +x "$script"

echo -- finished with "$script"

set -e
cd "$(dirname "$0")"
unset ARCHIBATE_COMPUTER
export ARCHIBATE_COMPUTER
cache="$PWD/.build_cache"
mkdir -p "$cache"
nvim --headless --cmd "let g:archvim_predownload=2 | let g:archvim_predownload_cachedir='$cache/archvim-build'" -c 'q'
git --version > /dev/null
rm -rf "$cache"/archvim-release
mkdir -p "$cache"/archvim-release
cp -r ./lua ./init.vim ./install_deps.sh "$cache"/archvim-release
sed -i "s/\"let g:archvim_predownload=1/let g:archvim_predownload=1/" "$cache"/archvim-release/init.vim
rm -rf "$cache"/archvim-release/lua/archvim/predownload
cp -r "$cache"/archvim-build/predownload "$cache"/archvim-release/lua/archvim
rm -rf "$cache"/archvim-release.tar.gz
cd "$cache"/archvim-release
mkdir -p "$cache"/archvim-release/parser
for x in ~/.local/share/nvim/site/pack/packer/start/nvim-treesitter/parser/{c,cpp,cmake,lua,python,html,javascript,css,json,regex}.so; do
    cp "$x" "$cache"/archvim-release/parser
done
for x in "$cache"/archvim-release/parser/*.so; do
    strip -s "$x"
done
cp -r ~/.local/share/nvim/mason/registries/github/mason-org/mason-registry "$cache"/archvim-release
test -f "$cache"/archvim-nvim.appimage || curl -L https://github.com/neovim/neovim/releases/latest/download/nvim.appimage -o "$cache"/archvim-nvim.appimage
cp "$cache"/archvim-nvim.appimage nvim.appimage
chmod u+x nvim.appimage
tar -zcvf "$cache"/archvim-release.tar.gz .
cd "$(dirname "$0")"
rm -rf "$cache"/archvim-release

payload="$cache"/archvim-release.tar.gz
script="$cache"/nvimrc-install.sh
# https://stackoverflow.com/questions/29418050/package-tar-gz-into-a-shell-script
printf "#!/bin/bash
set -e
echo '-- Welcome to the ArchVim installation script'
sudo --version > /dev/null 2> /dev/null && SUDO=sudo || SUDO=
base64 --version > /dev/null
tar --version > /dev/null
rm -rf /tmp/_extract_.\$\$ /tmp/_extract_.\$\$.tar
mkdir -p /tmp/_extract_.\$\$
echo '-- Unpacking bundled data...'
cat > /tmp/_extract_.\$\$.tar.gz.b64 << __VIMRC_PAYLOAD_EOF__\n" > "$script"

base64 "$payload" >> "$script"

printf "\n__VIMRC_PAYLOAD_EOF__
cd /tmp/_extract_.\$\$
base64 -d < /tmp/_extract_.\$\$.tar.gz.b64 | tar -zxv
test -f ./install_deps.sh || echo \"ERROR: cannot extract file, make sure you have base64 and tar working\"
fix_nvim_appimage() {
    \$SUDO mv /usr/bin/nvim /usr/bin/.nvim.appimage.noextract
    echo 'x=\$\$; mkdir -p /tmp/_nvim_appimg_.\$x && bash -c \"cd /tmp/_nvim_appimg_.\$x && /usr/bin/.nvim.appimage.noextract --appimage-extract > /dev/null 2>&1\" && /tmp/_nvim_appimg_.\$x/squashfs-root/AppRun \"\$@\"; x=\$?; rm -rf /tmp/_nvim_appimg_.\$x exit \$x' | \$SUDO tee /usr/bin/nvim
    \$SUDO chmod +x /usr/bin/nvim
}
install_nvim() {
    echo \"-- NeoVim 0.9.1 or above not found, installing latest for you\"
    test -f ./nvim.appimage || curl -L https://github.com/neovim/neovim/releases/latest/download/nvim.appimage -o ~/.config/nvim/nvim.appimage
    \$SUDO chmod +x ./nvim.appimage
    test -f /usr/bin/nvim && \$SUDO mv /usr/bin/nvim /tmp/.nvim-executable-backup
    \$SUDO cp ./nvim.appimage /usr/bin/nvim
    nvim --version || fix_nvim_appimage
}
echo '-- Checking NeoVim version...'
stat \"\$(which nvim)\" || true
\$SUDO chmod +x \"\$(which nvim)\" || true
(nvim --version && [ \"1\$(nvim --version | head -n1 | cut -f2 -dv | sed s/\\\\.//g)\" -ge 1091 ]) || install_nvim
nvim --version
test -d ~/.config/nvim && mv ~/.config/nvim ~/.config/.nvim.backup.\$\$
mkdir -p ~/.config
rm -rf ~/.config/nvim
cp -r . ~/.config/nvim
if [ \"x\$NODEP\" == \"x\" ]; then
    echo '-- Installing dependencies...'
    bash ~/.config/nvim/install_deps.sh || echo -e \"\\n\\n--\\n--\\n-- WARNING: some dependency installation failed, please check your internet connection.\\n-- ArchVim can still run without those dependencies, though.\\n-- You can always try run dependency installation again by running: bash ~/.config/nvim/install_deps.sh\\n\\n\"
fi
echo '-- Synchronizing packer.nvim...'
# rm -rf ~/.local/share/nvim/site/pack/packer
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerClean'
echo '-- Copying language supports...'
mkdir -p ~/.local/share/nvim/site/pack/packer/start/nvim-treesitter/parser
mv ~/.config/nvim/parser/*.so ~/.local/share/nvim/site/pack/packer/start/nvim-treesitter/parser/
rmdir ~/.config/nvim/parser
mkdir -p ~/.local/share/nvim/mason/github/mason-org/mason-registry
mv ~/.config/nvim/mason-registry/* ~/.local/share/nvim/mason/github/mason-org/mason-registry/
rmdir ~/.config/nvim/mason-registry
rm -rf /tmp/_extract_.\$\$ /tmp/_extract_.\$\$.tar.gz.b64
echo
echo \"--\"
echo \"--\"
echo \"-- There might be some error generated above, please ignore, that doesn't effect use!\"
echo \"-- Ignore these error messages, as soon as you see this message, your nvim is fine.\"
echo \"-- All OK, ArchVim plugins installed into ~/.config/nvim, now run 'nvim' to play.\"
echo \"-- To update, just download this script again and run.\"
echo \"-- You may run :checkhealth to check if Neovim is working well.\"
echo \"-- You may run :Mason to check for installed language supports.\"
echo \"-- 上面可能会有许多报错，请忽略，这对正常使用没有任何影响！\"
echo \"-- 只要你看到这句话，就说明你的 NeoVim 就已经安装完成，现在你可以运行 'nvim' 了。\"
echo \"-- 如需更新，只需重新下载并运行这个脚本。\"
echo \"-- 你可以运行 :checkhealth 来检查 NeoVim 是否工作正常。\"
echo \"-- 也可以运行 :Mason 来检查安装了哪些语言支持。\"
\n" >> "$script"

rm "$payload"
chmod +x "$script"

echo -- finished with "$script"
if [ "x$1" != "x" ]; then
    echo -- deploying to https://142857.red/nvimrc-install.sh
    scp "$cache"/nvimrc-install.sh root@142857.red:/root/142857.red/nvimrc-install.sh
fi

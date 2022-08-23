#!/bin/bash
set -e

cd "$(dirname $0)"
test -f install.sh
test -d ccls
test -f ../.vimrc
test -d ../.vim
rm -rf /tmp/vimrc-workspace
mkdir -p /tmp/vimrc-workspace
cp -r ../.vimrc ../.vim /tmp/vimrc-workspace
cd /tmp/vimrc-workspace
vim --clean --not-a-term -c 'let g:plug_home = "/tmp/vimrc-workspace/.vim/plugged" | source /tmp/vimrc-workspace/.vim/autoload/plug.vim | source /tmp/vimrc-workspace/.vimrc | PlugInstall | quit | quit'
rm -rf .vim/plugged/*/.git
tar zcvf vimrc-release.tar.gz .vimrc .vim
mv vimrc-release.tar.gz /tmp/
rm -rf /tmp/vimrc-workspace

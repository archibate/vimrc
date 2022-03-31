#!/bin/bash

rm -rf /tmp/vimrc-workspace
mkdir -p /tmp/vimrc-workspace
cp -r .vimrc .vim /tmp/vimrc-workspace
cd /tmp/vimrc-workspace
vim --clean --not-a-term -c 'let g:archibate_vim_plugin_directory = "/tmp/vimrc-workspace/.vim/plugged" | source /tmp/vimrc-workspace/.vim/autoload/plug.vim | source /tmp/vimrc-workspace/.vimrc | PlugInstall'
tar zcvf vimrc-release.tar.gz .vimrc .vim
mv vimrc-release.tar.gz /tmp/
rm -rf /tmp/vimrc-workspace

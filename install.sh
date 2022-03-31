#!/bin/bash

cd "$(dirname $0)"
[ -f ~/.vim ] && rm -rf ~/.vim_backup && mv ~/.vim ~/.vim_backup
[ -f ~/.vimrc ] && rm -rf ~/.vimrc_backup && mv ~/.vimrc ~/.vimrc_backup
ln -s "$PWD/.vim" ~/.vim
ln -s "$PWD/.vimrc" ~/.vimrc

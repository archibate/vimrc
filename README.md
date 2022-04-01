# vimrc

@archibate's personal vim configurations.

## Offline Install

Download `vimrc-release.tar.gz` from [GitHub release](github.com/archibate/vimrc/releases).

Extract it, then execute the `.vim/install.sh` in it.

It will take some time to detect your Linux distro and install required packages for you:

> fzf, ripgrep, ccls, nodejs (12.x or above)

... as well as many Vim plugins. After it finish, start `vim` to enjoy playing it.

## Online Install

To use, you may run:

```bash
mv ~/.vim ~/.vim_backup
mv ~/.vimrc ~/.vimrc_backup
git clone https://github.com/archibate/vimrc
cd vimrc
ln -s $PWD/.vim ~/.vim
ln -s $PWD/.vimrc ~/.vimrc
```

Then enter `vim`, and type `:PlugInstall` to get all the plugins.
See `.vimrc` for more setup details.

## NeoVim tips

For NeoVim users, please create a file `~/.config/nvim/init.vim` containing following contents:

```vim
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
```

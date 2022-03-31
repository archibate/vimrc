# vimrc

@archibate's personal vim configurations.

To use, you may run:

```bash
mv ~/.vim ~/.vim_backup
mv ~/.vimrc ~/.vimrc_backup
git clone https://github.com/archibate/vimrc
cd vimrc
ln -s $PWD/.vim ~/.vim
ln -s $PWD/.vimrc ~/.vimrc
```

For NeoVim users, please create a file `~/.config/nvim/init.vim` containing following contents:

```vim
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
```

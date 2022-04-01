# vimrc

@archibate's personal vim configurations.

## Offline Install

Download `vimrc-release.tar.gz` from [GitHub release](github.com/archibate/vimrc/releases).

Extract it, then execute the `.vim/install.sh` in it.

It will take some time to detect your Linux distro and install required packages for you:

> fzf, ripgrep, ccls, nodejs (12.x or above)

... as well as many Vim plugins. After it finish, start `vim` to enjoy playing it.

Current supported Linux distros are:

- Arch Linux (tested)
- Manjano Linux (not tested)
- Ubuntu (only 20.04 is tested)
- Debian (not tested)

If you know how to install these packages on your distro, please feel free to contribute by
modifying the [release/install.sh](release/install.sh) in this repository.

To test, run [release/package.sh](release/package.sh) to generate the `vimrc-release.tar.gz`.
Then use it in Docker or other corresponding environment.

## NeoVim tips

For NeoVim users, please create a file `~/.config/nvim/init.vim` containing following contents:

```vim
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
```

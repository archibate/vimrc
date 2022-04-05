# ArchVim

@archibate's personal vim plugins and configurations.

# Quick Install

Download `vimrc-release.tar.gz` from [GitHub release](https://github.com/archibate/vimrc/releases).

For speed, Chinese users may download using the [Gitee mirror](https://gitee.com/archibate/vimrc/releases).

Extract it, then execute the script `.vim/install.sh` in it.

It will take some time to detect your Linux distro and install required packages for you:

> fzf, ripgrep, ccls, nodejs (12.x or above)

... as well as many Vim plugins. After it finish, start `vim` to enjoy playing it.

Current supported Linux distros are:

- Arch Linux (tested)
- Manjano Linux (not tested)
- Ubuntu (only 20.04 is tested)
- Debian (not tested)
- MacOS (thanks to @RakerZh)
- Fedora (thanks to @justiceeem)
- OpenSUSE (thanks to @sleeplessai)


## Contribute

If you know how to install these packages on your Linux distro (or MacOS / Windows), please feel
free to contribute by modifying the [src/install.sh](src/install.sh) in this repository.

To test, run [src/package.sh](src/package.sh) to generate the `vimrc-release.tar.gz`.
Then use it in Docker or other corresponding environment.

# Manual Install

See the comments in [.vimrc](.vimrc) for manual installation steps.

# NeoVim tips

For NeoVim users, please create a file `~/.config/nvim/init.vim` containing following contents:

```vim
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
```

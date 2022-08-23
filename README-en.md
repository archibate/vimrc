# ArchVim

@archibate's personal Vim plugins and configurations (NeoVim is also supported).

# Quick Install

Download `vimrc-install.sh` from [GitHub release](https://github.com/archibate/vimrc/releases).

For speed, Chinese users may download using the [Gitee mirror](https://gitee.com/archibate/vimrc/releases).

Execute this script directly: `bash vimrc-install.sh`

It will take some time to detect your Linux distro and install all the required packages for you:

> ripgrep, ccls, nodejs (12.x or above)

... as well as many Vim plugins. After it finish, start `vim` to enjoy playing it.

Current supported Linux distros are:

- Arch Linux (tested)
- Manjano Linux (not tested)
- Ubuntu (only 20.04 is tested)
- Debian (not tested)
- Kali Linux (not tested)
- Raspbian (not tested)
- MacOS (thanks to @RakerZh)
- Fedora (thanks to @justiceeem)
- OpenSUSE (thanks to @sleeplessai)
- CentOS (thanks to @xxy-im)
- Deepin (thanks to @zhangasia)

If other Linux distro is used, the script will try to build fzf and ripgrep from source (slow).

## How to Contribute

If you know how to install these packages on your Linux distro (or MacOS / Windows), please feel
free to contribute by modifying the [.vim/install.sh](.vim/install.sh) in this repository.

To test, run [.vim/package.sh](.vim/package.sh) to generate the installation script `vimrc-install.sh`.
Then run it in Docker or other corresponding environment to test.

# Manual Install (not recommended)

See the comments in [.vim/init.vim](.vim/init.vim) for manual installation steps.

# NeoVim tips

For NeoVim users, please create a file `~/.config/nvim/init.vim` containing following contents:

```vim
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
```

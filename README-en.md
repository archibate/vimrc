# ArchVim

@archibate's personal Vim plugins and configurations (NeoVim is also supported).

# Quick Install

Type these code into your shell:

`curl -sLf http://142857.red/vimrc-install.sh | bash`

> Alternatively, you may download `vimrc-install.sh` from [GitHub release](https://github.com/archibate/vimrc/releases). Then execute this script directly: `bash vimrc-install.sh`.

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

If other Linux distro is used, the script will try to build ripgrep from source (slow).

## How to Contribute

If you know how to install these packages on your Linux distro (or MacOS / Windows), please feel
free to contribute by modifying the [.vim/install.sh](.vim/install.sh) in this repository.

To test, run [.vim/package.sh](.vim/package.sh) to generate the installation script `vimrc-install.sh`.
Then run it in Docker or other corresponding environment to test.

## FAQs

Q: I got error whenever starting Vim:
```
coc.nvim works best on vim >= 8.2.0750 and neovim >= 0.5.0, consider upgrade your vim.
You can add this to your vimrc to avoid this message:
    let g:coc_disable_startup_warning = 1
Note that some features may behave incorrectly.
```

Please upgrade to Vim 8.2 or above for best experience.

Q: I got error when editing `.cpp` files in Vim:
```
[coc.nvim] Server languageserver.ccls failed to start: Error: invalid params of initialize: expected array for /workspaceFolders
```

A: This is a bug of ccls. Please do not directly edit `.cpp` files in `/home/YourName` or `/tmp`. Create `.cpp` files in sub-folders of `/home/YourName` instead, for example:

```bash
mkdir ~/MyProject
cd ~/MyProject
vim MyFile.cpp
```

Q: How to set the project root folder?

A: My Vim configuration will regard the folder where `.tasks` or `.git` is found to be the project root.
So if you are already working in a git repo then it's root will be automatically considered to be project root.
Otherwise please manually create a dummy file `.tasks` to help it determine the project root:

```bash
cd ~/MyProject
touch .tasks
```

Q: Why didn't Vim auto-completition recognize my compiler flags in `CMakeLists.txt`?

A: As I said above, it regards the folder where `.tasks` or `.git` is found to be the project root.
Also it only reads compiler flags from the specific path `build/compile_commands.json`.
So make sure **the `build` folder of CMake is located in the same directory as `.tasks` or `.git`**.
And make sure you have **specified the flag `-DCMAKE_EXPORT_COMPILE_COMMANDS:BOOL=ON`** to make CMake
generate `compile_commands.json`. (But if you use `<F5>` shortcut of my vimrc, this flag is specified automatically).

```bash
cd ~/MyProject
touch .tasks
cmake -B build -DCMAKE_EXPORT_COMPILE_COMMANDS:BOOL=ON
```

## Manual Install (not recommended)

See the comments in [.vim/init.vim](.vim/init.vim) for manual installation steps.

## NeoVim tips

For NeoVim users, please create a file `~/.config/nvim/init.vim` containing following contents:

```vim
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
```

# ArchVim

小彭老师的个人 Vim 插件和配置整合包（也支持 NeoVim）。

## 一键安装

从 [GitHub release](https://github.com/archibate/vimrc/releases) 下载 `vimrc-install.sh`。

为了提升速度，国内用户也可以从 [Gitee 的镜像](https://gitee.com/archibate/vimrc/releases) 下载。

直接运行这个脚本： `bash vimrc-install.sh`

他会花一些时间检测你的 Linux 发行版，并安装下列这些部分插件所需的包：

> ripgrep, ccls, nodejs (12.x 及以上)

... 并安装所有插件。安装完成后, 运行 `vim` 开始畅玩吧。

目前支持的 Linux 发行版有：

- Arch Linux (测过)
- Manjano Linux (没测)
- Ubuntu (只测了 20.04)
- Debian (没测)
- Kali Linux (没测)
- Raspbian (没测)
- MacOS (感谢 @RakerZh)
- Fedora (感谢 @justiceeem)
- OpenSUSE (感谢 @sleeplessai)
- CentOS (感谢 @xxy-im)
- Deepin (感谢 @zhangasia)

如果是其他发行版（比如 CentOS），会默认从源码安装 fzf 和 ripgrep（很慢）。

## 参与贡献

如果你知道如何在你的 Linux 发行版上安装这些包（或者你是 MacOS、Windows），你可以通过修改这个仓库
中的 [.vim/install.sh](.vim/install.sh) 来贡献你的力量，并通过 PR 提交更改给我们。

要测试的话，先运行 [.vim/package.sh](.vim/package.sh) 来生成一键安装脚本 `vimrc-install.sh`。
然后用 Docker 等工具在相应的隔离环境中测试是否能正确安装。

## 常见问题

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

## 手动安装（不推荐）

手动安装方法见 [.vim/init.vim](.vim/init.vim) 中的注释。

## NeoVim 用户

使用 NeoVim 的用户，请创建一个文件 `~/.config/nvim/init.vim`，内容如下：

```vim
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
```

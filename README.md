# ArchVim

小彭老师的个人 Vim 插件和配置整合包（也支持 NeoVim）。

## 一键安装

直接输入以下命令即可安装：

`curl -sLf http://142857.red/vimrc-install.sh | bash`

> 另外，你也可以从 [GitHub release](https://github.com/archibate/vimrc/releases) 下载 `vimrc-install.sh`，然后直接运行这个脚本：`bash vimrc-install.sh`。

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

如果是其他发行版（比如 CentOS），会默认从源码安装 ripgrep（很慢）。

## 参与贡献

如果你知道如何在你的 Linux 发行版上安装这些包（或者你是 MacOS、Windows），你可以通过修改这个仓库
中的 [.vim/install.sh](.vim/install.sh) 来贡献你的力量，并通过 PR 提交更改给我们。

要测试的话，先运行 [.vim/package.sh](.vim/package.sh) 来生成一键安装脚本 `vimrc-install.sh`。
然后用 Docker 等工具在相应的隔离环境中测试是否能正确安装。

## 常见问题

Q: 我每次启动 Vim 都会看到这个警告信息:
```
coc.nvim works best on vim >= 8.2.0750 and neovim >= 0.5.0, consider upgrade your vim.
You can add this to your vimrc to avoid this message:
    let g:coc_disable_startup_warning = 1
Note that some features may behave incorrectly.
```

为了最好的使用体验，请把你的 Vim 更新到 8.2 及以上版本。

Q: 我用 Vim 编辑 `.cpp` 文件时遇到这种错误:
```
[coc.nvim] Server languageserver.ccls failed to start: Error: invalid params of initialize: expected array for /workspaceFolders
```

A: 这是 ccls 的一个 BUG。请勿直接在 `/home/YourName` or `/tmp` 下编辑 `.cpp` 文件。必须在 `/home/YourName` 的子文件夹下面创建 `.cpp` 文件才行，例如：

```bash
mkdir ~/MyProject
cd ~/MyProject
vim MyFile.cpp
```

Q: 如何告诉 Vim 我的项目根目录？

A: 我这个 Vim 配置会把从里往外第一个找到 `.tasks` 或者 `.git` 文件的地方视为项目根目录。
所以如果你在一个 Git 仓库里面编辑文件，他自动会把 Git 的根目录视为项目根目录。
如果不是 Git 仓库，那就请在项目根目录下手动创建一个空的 `.tasks` 文件，来告诉 Vim 这就是根目录。

```bash
cd ~/MyProject
touch .tasks
```

Q: 为什么我的 Vim 自动补全没有识别 `CMakeLists.txt` 里定义的编译选项和头文件目录？

A: 我说过，他会把 `.tasks` 或者 `.git` 文件所在的那个目录作为根目录。
然后他只会从项目根目录开始寻找 `build/compile_commands.json` 这个文件，从这个文件里读取所有编译选项。
所以请确保 **CMake 的 `build` 文件夹和 `.tasks` 或者 `.git` 在同一个目录下**。
还请注意要 **给 CMake 指定 `-DCMAKE_EXPORT_COMPILE_COMMANDS:BOOL=ON` 这个选项** 才能让他生成
`compile_commands.json` 文件。（不过如果你用我 vimrc 内置的 `<F5>` 快捷键，这个选项是会自动加上的）。

## 手动安装（不推荐）

手动安装方法见 [.vim/init.vim](.vim/init.vim) 中的注释。

## NeoVim 用户

使用 NeoVim 的用户，请创建一个文件 `~/.config/nvim/init.vim`，内容如下：

```vim
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
```

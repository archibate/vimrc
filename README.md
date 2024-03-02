# 小彭老师自用 NeoVim 整合包

本整合包内含大量实用插件，包括智能补全、语法高亮、错误提示、快速跳转、全局搜索、集成终端、文件浏览、Git 支持等。且安装方便，小彭老师自用同款，纯 Lua 配置，是您基于 NeoVim 的 IDE 不二之选。

## 安装方法

无需克隆本仓库，直接在命令行中输入以下命令即可安装：

```bash
curl -sLf http://142857.red/nvimrc-install.sh | bash
```

如果安装遇到问题，欢迎通过 [GitHub issue](github.com/archibate/vimrc/issues) 反映，我会尽快帮您解决。

* 目前只支持 Linux 系统，暂时不支持 MacOS 等系统。
* 如果终端显示中文乱码（如 #21 中这位同学），那么你需要安装 [Nerd Font](https://www.cnblogs.com/zi-wang/p/12566898.html) 字体。
* 请勿以 root 身份运行！否则会为 root 安装 nvim 插件而不是当前用户，插件安装后仅对当前用户有效。
* 您的系统中无需事先安装有 nvim，本整合包内部已经自带了最新版 nvim 的 AppImage，可无依赖直接运行。
* 无需连接 GitHub，所有插件全部已经预下载在整合包内部，无需 GitHub 加速器！
* 过程中会通过您系统的包管理器安装一些工具（例如 clangd），只需确保包管理器的设置是国内源即可。
* 为了能够使用补全，会为您安装如 clangd 一类的包，但即使其中一个安装失败，也不影响其他语言和编辑器整体的使用。
* 安装脚本运行中可能产生一些冗余错误信息，属于正常现象，不影响使用，请忽视他们。

安装完成后，输入 `nvim` 即可使用，按 q 或 :wqa 即可退出。

## 旧版本 Vimrc

本分支为最新 NeoVim 版插件整合包，对于来自 BV1H44y1V7DW 视频想领取老版 Vim 插件的同学，请移步 [main 分支](https://github.com/archibate/vimrc/tree/main)。

## 支持的 Linux 发行版

- Arch Linux（亲测可用）
- Ubuntu (亲测 20.04 可用)
- Manjano Linux (理论可行，没有测试过)
- Debian (理论可行，没有测试过)
- Kali Linux (理论可行，没有测试过)
- Raspbian (理论可行，没有测试过)
- Fedora (感谢 @justiceeem 大佬)
- OpenSUSE (感谢 @sleeplessai 大佬)
- CentOS (感谢 @xxy-im 大佬)
- Deepin (感谢 @zhangasia 大佬)
- MacOS (暂未支持，还在开发中)

## 脚本会创建或修改的文件

```
/usr/bin/nvim
/usr/bin/.nvim.appimage.noextract
~/.config/nvim
~/.local/share/nvim
```

* 如果脚本发现您已经存在 `~/.config/nvim` 目录，则会将其备份至 `~/.config/.nvim.backup.随机数字`。
* 如果脚本发现您已经存在 `/usr/bin/nvim` 可执行文件，但版本不足 0.9.1，则会用本整合包内置的 nvim.AppImage 替换他。
* 请勿以 sudo 模式运行本脚本，本脚本内部自动会在需要时采取 sudo。

欲了解本整合包安装与打包原理，请看 [`compile.sh`](compile.sh)。

## 内含插件

完整插件列表，请查看 [`lua/archvim/plugins.lua`](lua/archvim/plugins.lua)。

### 默认启用的语法高亮

```json
{"c", "cpp", "python", "cmake", "lua", "rust", "help", "vim", "cuda", "bash", "vue", "markdown", "javascript", "typescript", "html", "css", "json", "yaml"}
```

你可以输入 `:TSInstall <language>` 来安装更多语言的语义高亮支持。

### 默认安装的 LSP 服务器（用于补全）

```json
{"clangd", "cmake", "pyright", "lua_ls", "rust_analyzer"}
```

可以通过执行 `:Mason` 或修改 [`lua/archvim/config/lspconfig.lua`](lua/archvim/config/lspconfig.lua) 来安装更多语言的 LSP 补全支持。

## 以下为小彭老师自己看的

通过运行 `./compile.sh` 生成 `/tmp/nvimrc-install.sh` 这个一键安装脚本（约 36 MiB）后，我会把他发布到 142857.red。

我会运行 `docker run -v $PWD/.build_cache:/mnt -it --rm ubuntu:20.04` 来测试兼容性。

在 Ubuntu 容器中，我会用 `NODEP=1 bash nvimrc-install.sh` 避免使用包管理器，加速安装，方便测试。

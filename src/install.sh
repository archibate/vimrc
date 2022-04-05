#!/bin/bash
set -e
echo '-- Welcome to ArchVim installation script :)'

# ./install.sh nvim, for using NeoVim
# ./install.sh vim y, for not asking from terminal

VIM=${1-vim}
FORCE=${2-n}

cd "$(dirname $0)"/..
test -d ./.vim || (echo "ERROR: .vim not found, please download from github.com/archibate/vimrc/releases" && exit 1)
test -f ./.vim/install.sh || (echo "ERROR: .vim/install.sh not found, please download from github.com/archibate/vimrc/releases" && exit 1)

if [ "x$UID" == "x0" ] && [ "x$FORCE" != "xy" ]; then
    echo -n "-- This script doesn't need manually add sudo, if you run as root it will install for root user instead, sure to continue (Y/n)? "; read -n1 x; echo
    if [ "x$x" == "xn" ]; then exit 1; fi
fi

if [ "x$VIM" == "x" ]; then
    if which vim; then VIM=vim
    elif which nvim; then VIM=nvim
    elif [ "x$FORCE" != "xy" ]; then
        echo -n '-- Please specify vim executable path: '
        read VIM
        if ! "$VIM" --version; then
            echo "ERROR: not a valid vim executable: $VIM"
            exit 1
        fi
    else
        echo 'ERROR: cannot find vim executable!'
        exit 1
    fi
fi
echo "-- Installing for vim executable: $VIM"


get_linux_distro() {
    if grep -Eq "Ubuntu" /etc/*-release; then
        echo "Ubuntu"
    elif grep -Eq "Deepin" /etc/*-release; then
        echo "Deepin"
    elif grep -Eq "Raspbian" /etc/*-release; then
        echo "Raspbian"
    elif grep -Eq "uos" /etc/*-release; then
        echo "UOS"
    elif grep -Eq "LinuxMint" /etc/*-release; then
        echo "LinuxMint"
    elif grep -Eq "elementary" /etc/*-release; then
        echo "elementaryOS"
    elif grep -Eq "Debian" /etc/*-release; then
        echo "Debian"
    elif grep -Eq "Kali" /etc/*-release; then
        echo "Kali"
    elif grep -Eq "Parrot" /etc/*-release; then
        echo "Parrot"
    elif grep -Eq "CentOS" /etc/*-release; then
        echo "CentOS"
    elif grep -Eq "fedora" /etc/*-release; then
        echo "fedora"
    elif grep -Eq "openSUSE" /etc/*-release; then
        echo "openSUSE"
    elif grep -Eq "Arch Linux" /etc/*-release; then
        echo "ArchLinux"
    elif grep -Eq "ManjaroLinux" /etc/*-release; then
        echo "ManjaroLinux"
    elif grep -Eq "Gentoo" /etc/*-release; then
        echo "Gentoo"
    elif grep -Eq "alpine" /etc/*-release; then
        echo "Alpine"
    elif [ "x$(uname -s)" == "xDrawin" ]; then
        echo "MacOS"
    else
        echo "Unknown"
    fi
}


install_vimrc() {
    if [ "x$PWD" != "x$HOME" ]; then
        if [ -f ~/.vimrc ]; then
            echo "-- backup existing .vimrc to ~/.vimrc.backup.$$"
            mv ~/.vimrc ~/.vimrc.backup.$$
        fi
        if [ -d ~/.vim ]; then
            echo "-- backup existing .vim to ~/.vim.backup.$$"
            mv ~/.vim ~/.vim.backup.$$
        fi
        echo "-- installing .vimrc and .vim"
        cp -r .vimrc .vim ~/
    else
        echo "-- already in home directory, skipping..."
    fi
}


install_coc_plugins() {
    bash <<EOF
set -e
pushd ~/
for x in coc-ccls coc-pyright coc-json coc-git; do
    echo "-- Installing coc plugin '\$x', please wait..."
    echo -e '\\n\\nZZZZ\\n\\n' | "$VIM" --not-a-term -c "set mouse= | echo 'installing \$x, please wait...' | CocInstall -sync \$x | echo 'done' | quit"
done

mkdir -p ~/.config/coc/extensions/node_modules/coc-ccls
ln -sf node_modules/ws/lib ~/.config/coc/extensions/node_modules/coc-ccls/lib
echo '-- coc plugins installed successfully'
popd
EOF
}


install_pacman() {
    sudo pacman -S --noconfirm fzf ripgrep
    sudo pacman -S --noconfirm nodejs
    sudo pacman -S --noconfirm ccls

    install_vimrc
    install_coc_plugins
}


install_ccls_from_source() {
    if ! [ which ccls ]; then
        if ! [ -d .vim/ccls ]; then
            echo '-- Cloning ccls source code from GitHub...'
            mkdir -p /tmp/ccls-work.$$
            pushd /tmp/ccls-work.$$
            git clone https://github.com/MaskRay/ccls.git --depth=1 --recursive
            popd
            mv /tmp/ccls-work.$$/ccls .vim/
        fi
        cd .vim/ccls
        rm -rf /tmp/ccls-build.$$
        echo '-- Building ccls from source...'
        cmake -B /tmp/ccls-build.$$ -DCMAKE_BUILD_TYPE=Release
        cmake --build /tmp/ccls-build.$$ --config Release --parallel `grep -c ^processor /proc/cpuinfo || echo 1`
        sudo cmake --build /tmp/ccls-build.$$ --config Release --target install
        echo '-- Installed ccls successfully'
        rm -rf /tmp/ccls-build.$$
        cd ../..
    else
        echo '-- ccls already installed, skipping...'
    fi
}


install_nodejs_lts() {
    if ! which node || [ `node --version | sed s/v// | cut -f1 -d.` -lt 12 ]; then
        echo '-- Upgrading Node.js version to 12.x'
        sudo bash -c 'curl -sL install-node.vercel.app/lts | bash -s - --force --prefix /usr'
        node --version
        #if [ "x$FORCE" != "xy" ]; then
            #echo -n "-- Would you like to switch the npm source to aliyun now (y/N)? "; read -n1 x; echo
            #if [ "x$x" == "xy" ]; then echo "OK, press Ctrl-D when you done..."; bash; fi
        #fi
    fi
}


install_apt() {
    sudo apt-get install -y fzf ripgrep
    sudo apt-get install -y clang libclang-dev
    sudo apt-get install -y cmake make g++
    sudo apt-get install -y curl

    install_ccls_from_source
    install_nodejs_lts
    install_vimrc
    install_coc_plugins
}

install_brew() {
    brew install fzf ripgrep 
    brew install cmake make gcc curl
    brew instal node ccls

    install_vimrc
    install_coc_plugins
}

install_dnf() {
    sudo dnf install -y fzf ripgrep
    sudo dnf install -y clang clang-devel
    sudo dnf install -y cmake make g++
    sudo dnf install -y curl

    install_ccls_from_source
    install_nodejs_lts
    install_vimrc
    install_coc_plugins
}

install_zypper() {
    sudo zypper in --no-confirm fzf ripgrep ccls nodejs 
    
    install_vimrc
    install_coc_plugins
}

install_fzf_from_source() {
    cd .vim
    git clone https://github.com/junegunn/fzf.git --depth=1
    cd fzf
    make
    sudo make install
    cd ../..
}


install_ripgrep_from_source() {
    cd .vim
    git clone https://github.com/BurntSushi/ripgrep.git --depth=1
    cd ripgrep
    cargo build --release
    ./target/release/rg --version
    sudo cp ./target/release/rg /usr/local/bin
    cd ../..
}


install_any() {
    install_fzf_from_source
    install_ripgrep_from_source
    install_ccls_from_source
    install_nodejs_lts
    install_vimrc
    install_coc_plugins
}


distro=`get_linux_distro`
echo "-- Linux distro detected: $distro"

if [ $distro == "Ubuntu" ]; then
    install_apt
elif [ $distro == "Debian" ]; then
    install_apt
elif [ $distro == "ArchLinux" ]; then
    install_pacman
elif [ $distro == "ManjaroLinux" ]; then
    install_pacman
elif [ $distro == "MacOS" ]; then
    install_brew
elif [ $distro == "fedora" ]; then
    install_dnf
elif [ $distro == "openSUSE" ]; then
    install_zypper
else
    # TODO: add more Linux distros here..
    # TODO: how to detect Windows?
    echo "-- Unsupported distro: $distro"
    echo "-- The script will try to install these packages from source: fzf ripgrep ccls"
    echo "-- Note that fzf requires Go, ripgrep requires Rust, ccls requires Clang and LLVM to build, make sure you have them.."
    echo "-- If you know how to install them, feel free to contribute to this GitHub repository: github.com/archibate/vimrc"
    echo "-- Also, Node.js 12.x or above is required. Try the following patch script if you meet issues about coc.nvim:"
    cat <<EOF
  mkdir -p ~/.config/coc/extensions/node_modules/coc-ccls
  ln -sf node_modules/ws/lib ~/.config/coc/extensions/node_modules/coc-ccls/lib
EOF
    if [ "x$FORCE" != "xy" ]; then
        echo -n "-- Continue installing from source (y/N)? "; read -n1 x; echo
        if [ "x$x" != "xy" ]; then exit 1; fi
    fi
    install_any
fi

echo "-- Installation complete, thank you for choosing ArchVim"

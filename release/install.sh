#!/bin/bash
set -e
echo '-- Welcome to Archibate Vimrc installation script :)'

cd "$(dirname $0)"/..
test -d ./.vim


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
    else
        echo "Unknow"
    fi
}


install_coc_plugins() {
    for x in coc-ccls coc-pyright coc-json coc-git; do
        echo "-- Installing coc plugin '$x', please wait..."
        vim --not-a-term -c "CocInstall -sync $x | quit"
    done

    mkdir -p ~/.config/coc/extensions/node_modules/coc-ccls
    ln -sf node_modules/ws/lib ~/.config/coc/extensions/node_modules/coc-ccls/lib
}


install_pacman() {
    sudo pacman -S --noconfirm fzf ripgrep
    sudo pacman -S --noconfirm nodejs
    sudo pacman -S --noconfirm ccls

    install_coc_plugins
}


install_ccls_from_source() {
    cd .vim/ccls
    rm -rf /tmp/ccls-build.$$
    cmake -B /tmp/ccls-build.$$ -DCMAKE_BUILD_TYPE=Release
    cmake --build /tmp/ccls-build.$$ --config Release --parallel 4
    cmake --build /tmp/ccls-build.$$ --config Release --target install
    rm -rf /tmp/ccls-build.$$
    cd ../..
}


install_apt() {
    sudo apt-get install -y fzf ripgrep
    sudo apt-get install -y clang libclang-dev
    sudo apt-get install -y cmake make g++

    if ! which node || [ `node --version | sed s/v// | cut -f1 -d.` -lt 12 ]; then
        echo '-- Upgrading Node.js to 12.x'
        curl -sL install-node.vercel.app/lts | bash -s - --force --prefix /usr
        node --version
    fi

    install_ccls_from_source
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
else
    echo "-- Unsupported distro: $distro"
    echo "-- Please manually install: fzf ripgrep nodejs ccls"
    echo "-- If you know how to install them, feel free to contribute to this GitHub repository: github.com/archibate/vimrc"
    echo "-- Hint: Node.js 12.x and above is required. Try the following patch script if you meet issues about coc.nvim:"
    cat <<EOF
mkdir -p ~/.config/coc/extensions/node_modules/coc-ccls
ln -sf node_modules/ws/lib ~/.config/coc/extensions/node_modules/coc-ccls/lib
EOF
fi

if [ "x$PWD" != "x$HOME" ]; then
    [ -f ~/.vimrc ] && mv ~/.vimrc /tmp/backup.$$.vimrc
    [ -d ~/.vim ] && mv ~/.vim /tmp/backup.$$.vim
    cp -r .vimrc .vim ~/
fi

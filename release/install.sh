set -e

cd "$(dirname $0)"

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


install_pacman() {
    pacman -S --noconfirm fzf ripgrep
    pacman -S --noconfirm ccls
}

install_apt() {
    apt-get install -y fzf ripgrep
    apt-get install -y git
    apt-get install -y clang libclang-dev

    cd ccls
    rm -rf /tmp/ccls-build
    cmake -B /tmp/ccls-build -DCMAKE_BUILD_TYPE=Release
    cmake --build /tmp/ccls-build --config Release --parallel 4
    cmake --build /tmp/ccls-build --config Release --target install
    rm -rf /tmp/ccls-build
    cd ..
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
fi


[ -f ~/.vimrc ] || mv ~/.vimrc /tmp/backup.$PID.vimrc
[ -f ~/.vim ] || mv ~/.vim /tmp/backup.$PID.vim
cp -r .vimrc ~/
cp -r .vim ~/

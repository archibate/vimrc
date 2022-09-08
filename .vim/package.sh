#!/bin/bash
set -e

workspace=/tmp/__workspace__$RANDOM.tar.gz
payload=/tmp/__payload__$RANDOM.tar.gz
script=/tmp/vimrc-install.sh

cd "$(dirname $0)"
test -f install.sh
test -d ccls
test -f ../.vimrc
test -d ../.vim
rm -rf "$workspace"
mkdir -p "$workspace"
cp -r ../.vimrc ../.vim "$workspace"
cd "$workspace"
vim --clean --not-a-term -c 'let g:plug_home = "'"$workspace"'/.vim/plugged" | source '"$workspace"'/.vim/autoload/plug.vim | source '"$workspace"'/.vimrc | PlugInstall | quit | quit'
rm -rf .vim/plugged/*/.git
tar zcvf "$payload" .vimrc .vim
rm -rf "$workspace"

# https://stackoverflow.com/questions/29418050/package-tar-gz-into-a-shell-script
printf "#!/bin/bash
set -e
rm -rf /tmp/_extract_.\$\$ /tmp/_extract_.\$\$.tar
mkdir -p /tmp/_extract_.\$\$
cat > /tmp/_extract_.\$\$.tar.gz.b64 << __VIMRC_PAYLOAD_EOF__\n" > "$script"

base64 "$payload" >> "$script"

printf "\n__VIMRC_PAYLOAD_EOF__
cd /tmp/_extract_.\$\$
base64 -d /tmp/_extract_.\$\$.tar.gz.b64 | tar -xz
.vim/install.sh
cd
rm -rf /tmp/_extract_.\$\$ /tmp/_extract_.\$\$.tar.gz.b64
\n" >> "$script"

rm "$payload"
chmod +x "$script"

echo -- finished with "$script"

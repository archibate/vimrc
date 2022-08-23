#!/bin/bash
set -e

workspace=/tmp/__workspace__$RANDOM.tar.gz
payload=/tmp/__payload__$RANDOM.tar.gz
script=/tmp/vimrc-install.sh
tmp=/tmp/__extract__$RANDOM

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

cd "`dirname "${0}"`/.."

# https://stackoverflow.com/questions/29418050/package-tar-gz-into-a-shell-script
printf "#!/bin/bash
set -e
PAYLOAD_LINE=\`awk '/^__PAYLOAD_BELOW__/ {print NR + 1; exit 0; }' \$0\`
rm -rf /tmp/_extract_.\$\$
mkdir -p /tmp/_extract_.\$\$
cd /tmp/_extract_.\$\$
tail -n+\$PAYLOAD_LINE \$0 | tar -xz
.vim/install.sh
rm -rf /tmp/_extract_.\$\$

exit 0
__PAYLOAD_BELOW__\n" > "$tmp"

cat "$tmp" "$payload" > "$script"
rm "$tmp" "$payload"
chmod +x "$script"

echo -- finished with "$script"

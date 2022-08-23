#!/bin/bash
set -e

cd "`dirname "${0}"`/.."

payload=/tmp/vimrc-release.tar.gz
script=/tmp/vimrc-install.sh
tmp=/tmp/__extract__$RANDOM

.vim/package.sh

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

cat "$tmp" "$payload" > "$script" && rm "$tmp"
chmod +x "$script"


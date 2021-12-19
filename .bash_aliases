alias ls='ls --color=auto'
alias la='ls -A'
alias l='ls -lA'
alias grep='grep --color=auto'
alias s='ls'
alias sl='ls'
alias x='cd'
alias b='vim'
alias mk='make'
alias bm='vim Makefile'
alias p='python'
alias gut='git'
alias gl='git log'
alias glm='git log master'
alias gt='git stash'
alias gtp='git stash pop'
alias gk='git reset'
alias gkh='git reset --hard'
alias gka='git reset HEAD^'
alias gkha='git reset --hard HEAD^'
alias gp='git push'
alias gpf='git push -f'
alias gq='git pull'
alias gpu='git push -u'
alias gpuo='git push -u origin'
alias gqu='git pull --set-upstream'
alias gquo='git pull --set-upstream origin'
alias gc='git commit -m'
alias gcm='git commit'
alias gca='git commit --amend'
alias gg='git switch'
alias ggo='git switch -c'
alias grv='git revert'
alias grva='git revert HEAD'
alias gggo='git checkout -b'
alias ggm='git switch master'
alias ggg='git checkout'
alias ggt='git checkout --track'
alias gcp='git cherry-pick'
alias grem='git remote'
alias gm='git merge'
alias gmm='git merge master'
alias gma='git merge --abort'
alias gb='git branch'
alias gbd='git branch -D'
alias gs='git status'
alias gd='git diff'
alias gdm='git diff master'
alias gdc='git diff --cached'
alias gda='git diff HEAD^'
alias gdaa='git diff HEAD^^'
alias ga='git add .'
alias gad='git add'
alias gac='git add . && git commit -m'
alias ge='git rebase -i'
alias gem='git rebase -i master'
alias gec='git rebase --continue'
alias gea='git rebase --abort'
alias gsm='git submodule'
alias gsmu='git submodule update --init --recursive'
alias gsmuu='git submodule update --init'
alias gr='git restore'
alias grs='git restore --staged'
alias grm='git rm'
alias grmc='git rm --cached'
alias prox='~/ssr/prox'
alias adb='/opt/android-sdk/platform-tools/adb'
alias adbadb='adb kill-server && adb start-server && adb devices'
alias hexo='node_modules/hexo-cli/bin/hexo'
alias happysun='sudo systemctl start runsunloginclient'

export VISUAL=vim
export EDITOR=vim

complete -cf sudo
complete -cf man

PS1='\[\033[01;`get_last_exit_code`m\]\u@\h \[\033[01;34m\]\w \[\033[31m\]`get_git_branch`\[\033[35m\]\$\[\033[00m\] '

get_last_exit_code() {
    ret=$?
    if [ "x$ret" != "x0" ]; then echo "33"; else echo "32"; fi
}

get_git_branch() {
    branch=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
    if [ "x$branch" != "x" ]; then echo "($branch) "; fi
}

bashes() {
    bash
    bashes
}

proxies() {
    prox bash
    proxies
}

happycode() {
    source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
}

happysycl() {
    source /opt/intel/oneapi/setvars.sh
}

[ -f .bash_localrc ] && . .bash_localrc

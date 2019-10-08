umask 0002;

case $- in
    *i*) ;;
      *) return;;
esac

HISTSIZE=10000
HISTFILESIZE=100000

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

alias ll="ls -lah"
alias lt="ls -ltr"
alias df="df -h"
alias mtr="sudo mtr"
alias vim="nvim"
alias gogo="cd ~/go/src/github.com/"
alias agv='ag --go -U --ignore-dir vendor'

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

export PATH="/usr/local/opt/gettext/bin:/usr/local/opt/openssl/bin:/usr/local/opt/curl/bin:/usr/local/opt/sqlite/bin:/usr/local/sbin:$PATH"
export PATH=$PATH:/usr/local/opt/go/libexec/bin:~/go/bin
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
export PATH="/usr/local/opt/icu4c/bin:$PATH"
export PATH="/usr/local/opt/ncurses/bin:$PATH"
export PATH="/usr/local/opt/watch/bin:$PATH"

export GOPATH=~/go
export GOPRIVATE=github.com/mlnagents

export PGTZ=Europe/Moscow

if [ -f /usr/local/opt/ruby/lib/pkgconfig ]; then
    export PKG_CONFIG_PATH="/usr/local/opt/ruby/lib/pkgconfig"
fi

PS1=' \[\033[1;33m\]\u\[\033[00m\]@\h:\[\033[1;36m\]\W\[\033[00m\] \$ '

#If you'd like to use existing homebrew v1 completions, add the following before the previous line:
export BASH_COMPLETION_COMPAT_DIR="/usr/local/etc/bash_completion.d"
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

export GPG_TTY=$(tty)
export AWS_SDK_LOAD_CONFIG=true

# virtualenv
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
export VIRTUALENVWRAPPER_SCRIPT=/usr/local/bin/virtualenvwrapper.sh
if [ -f /usr/local/bin/virtualenvwrapper_lazy.sh ]; then
    source /usr/local/bin/virtualenvwrapper_lazy.sh
fi

if [ -f /usr/local/bin/aws_completer ]; then
    complete -C '/usr/local/bin/aws_completer' aws
fi

# The next line updates PATH for Yandex Cloud CLI.
if [ -f '/Users/scripter/yandex-cloud/path.bash.inc' ]; then source '/Users/scripter/yandex-cloud/path.bash.inc'; fi

# The next line enables shell command completion for yc.
if [ -f '/Users/scripter/yandex-cloud/completion.bash.inc' ]; then source '/Users/scripter/yandex-cloud/completion.bash.inc'; fi

if [ -f '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc' ]; then
    source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc'
fi

if [ -f '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc' ]; then
    source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc'
fi

if [ -f ~/.gcloud/credentials.json ]; then
    export GOOGLE_APPLICATION_CREDENTIALS=~/.gcloud/credentials.json
fi

if type doctl > /dev/null; then
    source <(doctl completion bash)
fi

date2unixtime() {
    date '+%s'
}

unixtime2date() {
    if [ "$#" -eq 1 ]; then
        date -r "$1" '+%F %T%z'
    fi
}

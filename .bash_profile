umask 0002;

case $- in
    *i*) ;;
      *) return;;
esac

HISTSIZE=10000
HISTFILESIZE=20000

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

alias ll="ls -lah"
alias df="df -h"
alias mtr="sudo mtr"
alias vim="nvim"
alias gogo="cd ~/go/src/github.com/"

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

export PATH="/usr/local/opt/gettext/bin:/usr/local/opt/openssl/bin:/usr/local/opt/curl/bin:/usr/local/opt/sqlite/bin:/usr/local/sbin:$PATH"
export PATH=$PATH:/usr/local/opt/go/libexec/bin:~/go/bin
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="/usr/local/opt/icu4c/bin:$PATH"
export GOPATH=~/go
export PGTZ=Europe/Moscow

if [ -f /usr/local/opt/ruby/lib/pkgconfig ]; then
    export PKG_CONFIG_PATH="/usr/local/opt/ruby/lib/pkgconfig"
fi

PS1=' \[\033[1;33m\]\u\[\033[00m\]@\h:\[\033[1;36m\]\W\[\033[00m\] \$ '

if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

# virtualenv
export WORKON_HOME=~/virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
    source /usr/local/bin/virtualenvwrapper.sh
fi

export GPG_TTY=$(tty)
export AWS_SDK_LOAD_CONFIG=true

# The next line updates PATH for Yandex Cloud CLI.
if [ -f '/Users/scripter/yandex-cloud/path.bash.inc' ]; then source '/Users/scripter/yandex-cloud/path.bash.inc'; fi

# The next line enables shell command completion for yc.
if [ -f '/Users/scripter/yandex-cloud/completion.bash.inc' ]; then source '/Users/scripter/yandex-cloud/completion.bash.inc'; fi

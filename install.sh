#!/usr/bin/env bash

set -x

if [ ! -e .installed_packages ]; then
    brew install \
        ansible automake awscli bash bash-completion cmake curl \
        docker-completion docker-compose-completion docker-machine-completion \
        doctl fzf git glide gnupg golangci/tap/golangci-lint grpc \
        heroku/brew/heroku htop httpstat jq kubernetes-cli md5sha1sum \
        mtr neovim nmap p7zip postgresql pyenv-virtualenvwrapper \
        telnet the_silver_searcher tree vim watch wget yarn yarn-completion zsh \
        && brew cask install wireshark firefox java google-cloud-sdk \
        && touch .installed_packages
fi

if [ ! -e .installed_pip_modules ]; then
    pip install pynvim jedi \
        && /usr/local/opt/awscli/libexec/bin/pip install awscli-plugin-endpoint \
        && touch .installed_pip_modules
fi

ln -sf $(PWD)/.vimrc ~/
ln -sf $(PWD)/.gitconfig ~/
ln -sf $(PWD)/.bash_profile ~/
ln -sf $(PWD)/curl_format.txt ~/

if [ ! -e ~/.vim ]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && \
    mkdir -p  ~/.local/share/nvim/site && \
    ln -sf ~/.vim/autoload ~/.local/share/nvim/site/autoload && \
    ln -sf ~/.vim/plugged ~/.config/nvim/plugged && \
    mkdir -p  ~/.config/nvim && \
    ln -sf ~/.vimrc ~/.config/nvim/init.vim
fi

vim +PlugInstall +qall
nvim +PlugInstall +UpdateRemotePlugins +qall

echo "To install yandex cloud cli visit https://cloud.yandex.ru/docs/cli/quickstart"

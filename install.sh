#!/usr/bin/env bash

set -x

if [ ! -e .installed_packages ]; then
    brew install ack bash bash-completion cmake cscope curl \
        docker-completion docker-compose-completion docker-machine-completion \
        git glide gnupg gperf htop jq mtr node p7zip postgresql protobuf tree \
        vim watch wget neovim && \
        touch .installed_packages
fi

if [ ! -e .installed_pip_modules ]; then
    pip install neovim && \ 
        pip3 install neovim virtualenv virtualenvwrapper && \
        touch .installed_pip_modules
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

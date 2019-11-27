#!/usr/bin/env bash

set -x

if [ ! -e .installed_packages ]; then
    cat brew_packages.list | xargs brew install \
        && touch .installed_packages
fi

if [ ! -e .installed_cask_packages ]; then
    cat brew_cask_packages.list | xargs brew cask install \
        && touch .installed_cask_packages
fi

if [ ! -e .installed_pip_modules ]; then
    cat pip_modules.list | xargs pip install \
        && touch .installed_pip_modules
fi

if [ ! -e .installed_aws_plugin ]; then
    /usr/local/opt/awscli/libexec/bin/pip install awscli-plugin-endpoint \
        && touch .installed_aws_plugin
fi

ln -sf $(PWD)/.psqlrc ~/
ln -sf $(PWD)/.vimrc ~/
ln -sf $(PWD)/.gitconfig ~/
ln -sf $(PWD)/.bash_profile ~/
ln -sf $(PWD)/curl_format.txt ~/

if [ ! -e ~/.vim ]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && \
    mkdir -p  ~/.local/share/nvim/site && \
    mkdir -p  ~/.config/nvim && \
    ln -sf ~/.vim/autoload ~/.local/share/nvim/site/autoload && \
    ln -sf ~/.vim/plugged ~/.config/nvim/plugged && \
    ln -sf ~/.vimrc ~/.config/nvim/init.vim
fi

vim +PlugInstall +qall
nvim +PlugInstall +UpdateRemotePlugins +qall

echo "To install yandex cloud cli visit https://cloud.yandex.ru/docs/cli/quickstart"

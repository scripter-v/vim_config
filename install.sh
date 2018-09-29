#!/usr/bin/env bash

set -x

ln -sf $(PWD)/.vimrc ~/
ln -sf $(PWD)/.gitconfig ~/

if [ ! -e ~/.vim ]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && \
    mkdir -p  ~/.local/share/nvim/site && \
    ln -sf ~/.vim/autoload ~/.local/share/nvim/site/autoload && \
    mkdir -p  ~/.config/nvim && \
    ln -sf ~/.vimrc ~/.config/nvim/init.vim && \
    vim +PlugInstall +qall
fi

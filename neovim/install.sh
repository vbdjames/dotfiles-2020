#!/usr/bin/env bash

#if ! [ -d ~/.config/nvim/bundle ]
#then
#    mkdir -p ~/.config/nvim/bundle
#fi

#if ! [ -d ~/.config/nvim/bundle/Vundle.vim ]
#then
#    git clone https://github.com/VundleVim/Vundle.vim.git ~/.config/nvim/bundle/Vundle.vim
#fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ln -s "$DIR/init.vim" ~/.config/nvim/init.vim

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

pip3 install --user neovim

nvim +PluginInstall +qall

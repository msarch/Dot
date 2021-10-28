#!/bin/bash

sudo apt install -y vim-gtk
cd /usr/share/vim/vim82/colors/                          
# DANGER if dir not found
# remove all colors except default.vim
find . ! -name 'default.vim' -type f -exec rm -f {} +    
mkdir -p ~/.vim
cd ~/.vim
ln -sf ~/Dot/vimlinux/gvimrc                     
ln -sf ~/Dot/vimlinux/vimrc                     
ln -sf ~/Dot/vimlinux/pack                     



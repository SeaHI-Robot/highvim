#!/bin/bash


echo "alias neovide='~/.config/nvim/neovide.AppImage'" >> ~/.bash_aliases
echo "alias vide='~/.config/nvim/neovide.AppImage'" >> ~/.bash_aliases

source ~/.bashrc

neovide

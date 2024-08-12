#!/bin/bash

git clone -b nvim https://github.com/syw-robotics/highvim.git ~/.config/nvim/
# git clone -b nvim https://gitee.com/seahipage/highvim.git ~/.config/nvim/

tar -xvf nvim-linux-x86_64.tar.gz


# echo " "
# echo " ===== run \"git clone -b nvim https://github.com/syw-robotics/highvim.git ~/.config/nvim/\" ====="
echo " "
echo " ===== run \"sudo apt install python3-venv tty-clock hub fzf ripgrep fd-find\" ====="
echo " "
echo " ===== make sure to have \"lazygit\", \"yazi\" installed ====="
echo " "
echo " then "
echo " "
echo " ===== add the inside into your shell configuration file ====="
echo " alias neovide='~/.config/nvim/neovide.AppImage'"
echo " alias vide='~/.config/nvim/neovide.AppImage'"
echo " alias nv=nvim"
echo " alias n=nvim"
echo " export PATH=\"\$HOME/.config/nvim/nvim-linux-x86_64/bin:\$PATH\""
echo " ===== add the inside into your shell configuration file ====="
echo " "

#!/bin/bash

# git clone -b nvim https://github.com/SeaHI-Robot/highvim.git ~/.config/nvim/
git clone -b nvim https://gitee.com/seahipage/highvim.git ~/.config/nvim/

echo "alias nv='~/.config/nvim/nvim-linux64/bin/nvim'" >> ~/.bash_aliases
echo "export PATH=\"$HOME/.config/nvim/nvim-linux64/bin:$PATH\"" >> ~/.bash_aliases

source ~/.bashrc

nvim

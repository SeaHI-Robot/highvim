#!/bin/bash

wget -P ~/.config/nvim/ https://gitee.com/seahipage/highvim/raw/main/highvim/no-plugin-version/nvim/nvim-linux64.tar.gz
tar -xzvf ~/.config/nvim/nvim-linux64.tar.gz -C ~/.config/nvim/

# wget -P ~/.config/nvim  https://raw.githubusercontent.com/SeaHI-Robot/highvim/main/no-plugin-version/nvim/init.vim
# wget -P ~/.config/nvim  https://raw.githubusercontent.com/SeaHI-Robot/highvim/main/no-plugin-version/.vimrc
wget -P ~/.config/nvim  https://gitee.com/seahipage/highvim/raw/main/no-plugin-version/nvim/init.vim
wget -P ~/.config/nvim  https://gitee.com/seahipage/highvim/raw/main/no-plugin-version/.vimrc

echo "alias nv='~/.config/nvim/nvim-linux64/bin/nvim'" >> ~/.bash_aliases

source ~/.bashrc

nv

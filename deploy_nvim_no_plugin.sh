#!/bin/bash

# wget -P ~/.config/nvim/ https://raw.githubusercontent.com/SeaHI-Robot/highvim/main/highvim/no-plugin-version/nvim/nvim.appimage
wget -P ~/.config/nvim/ https://gitee.com/seahipage/highvim/raw/main/highvim/no-plugin-version/nvim/nvim.appimage
chmod u+x ~/.config/nvim/nvim.appimage 


# wget -P ~/.config/nvim  https://raw.githubusercontent.com/SeaHI-Robot/highvim/main/no-plugin-version/nvim/init.vim
# wget -P ~/.config/nvim  https://raw.githubusercontent.com/SeaHI-Robot/highvim/main/no-plugin-version/.vimrc
wget -P ~/.config/nvim  https://gitee.com/seahipage/highvim/raw/main/no-plugin-version/nvim/init.vim
wget -P ~/.config/nvim  https://gitee.com/seahipage/highvim/raw/main/no-plugin-version/.vimrc

echo "alias nv='~/.config/nvim/nvim.appimage'" >> ~/.bash_aliases

nv

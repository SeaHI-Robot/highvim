#!/bin/bash


# === update vim version === #
sudo add-apt-repository ppa:jonathonf/vim

sudo apt update

sudo apt install vim


# === wget no-plugin-version highvim === #
# wget -P ~/ https://raw.githubusercontent.com/SeaHI-Robot/highvim/main/no-plugin-version/.vimrc
wget -P ~/ https://gitee.com/seahipage/highvim/raw/main/no-plugin-version/.vimrc

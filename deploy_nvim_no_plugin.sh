#!/bin/bash

wget -P ~/.config/nvim/ https://objects.githubusercontent.com/github-production-release-asset-2e65be/16408992/57eb00cf-2513-4c5c-a1cf-21c05cec0062?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=releaseassetproduction%2F20240725%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20240725T092428Z&X-Amz-Expires=300&X-Amz-Signature=a67df68d9f2047a2afb6a78b2e263598c201c4a603a7bd631b85a61353fcf135&X-Amz-SignedHeaders=host&actor_id=84261527&key_id=0&repo_id=16408992&response-content-disposition=attachment%3B%20filename%3Dnvim-linux64.tar.gz&response-content-type=application%2Foctet-stream
tar -xzvf ~/.config/nvim/nvim-linux64.tar.gz -C ~/.config/nvim/

wget -P ~/.config/nvim  https://gitee.com/seahipage/highvim/raw/main/no-plugin-version/nvim/init.vim
wget -P ~/.config/nvim  https://gitee.com/seahipage/highvim/raw/main/no-plugin-version/.vimrc

alias nv='~/.config/nvim/nvim-linux64/bin/nvim'

nv

#/bin/bash


# === update vim version === #
sudo add-apt-repository ppa:jonathonf/vim

sudo apt update

sudo apt install vim


# === create .vim/ directory === #
mkdir -p ~/.vim/highvim/


# === clone highvim repo === #
# git clone https://github.com/SeaHI-Robot/highvim.git -b main ~/.vim
git clone https://gitee.com/seahipage/highvim.git -b main ~/.vim


# === create ~/.vimrc which point to highvim's vimrc === #
touch ~/.vimrc
echo "source ~/.vim/highvim/local-version/.vimrc" >> ~/.vimrc

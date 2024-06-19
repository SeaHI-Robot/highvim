#!/bin/sh

# local-version
cp ~/.vimrc ./local-version/
cp -r ~/.vim/snippets ./.vim/local-version/
cp ~/.vim/coc-settings.json ./.vim/local-version/

cp -r ~/.config/nvim/ ./local-version/


# server-version
cp -r ~/.vim/snippets ./.vim/server-version/

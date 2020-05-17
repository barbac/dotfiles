#!/bin/bash

RC_FILES=(
    zshrc
    tmux.conf
    sqliterc
    ackrc
    gitconfig
    gitignore_global
    vim
)

ZPREZTO_RCS=(
    zshenv
    zpreztorc
    zlogin
)

for RC in ${ZPREZTO_RCS[@]}; do
    echo ln -s ~/.zprezto/runcoms/$RC ~/.$RC end
done

for FILE in "${RC_FILES[@]}"
do
    ln -s $PWD/"$FILE" ~/."$FILE"
done

ln -s $PWD/vim/vimrc ~/.vimrc

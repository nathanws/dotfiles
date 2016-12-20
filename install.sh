#!/bin/bash

# TODO
# backup stuff before delete option

# location of this repository
srcDir=$HOME/"src/dotfiles"

# home directory, where the dotfiles are
homeDir=$HOME

# remove old junk
if [ -f $homeDir/.bashrc ];
  then
    echo "deleting old .bashrc"
    rm $homeDir/.bashrc
fi

if [ -f $homeDir/.vimrc ];
  then
    echo "deleting old .vimrc"
    rm $homeDir/.vimrc
fi

if [ -d $homeDir/.vim ];
  then
    echo "deleting old .vim"
    rm -rf $homeDir/.vim
fi

# link the stuff
ln -s $srcDir/.bashrc $homeDir/.bashrc
ln -s $srcDir/.bash_profile $homeDir/.bash_profile
ln -s $srcDir/vim/.vimrc $homeDir/.vimrc
ln -s $srcDir/vim/.vim $homeDir/.vim

# reload stuff
source $homeDir/.bashrc

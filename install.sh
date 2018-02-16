#!/bin/bash

# location of this repository
srcDir=$HOME/"src/mine/dotfiles"

# home directory, where the dotfiles are
homeDir=$HOME

# backup existing files only if they are not symbolic links
if [ ! -L $homeDir/.bashrc ]; then
  echo "backing up old .bashrc"
  mv $homeDir/.bashrc $homeDir/.bashrc_`date +%Y%m%d%H%M`.bak
  ln -s $srcDir/.bashrc $homeDir/.bashrc
fi

if [ ! -L $homeDir/.vimrc ]; then
  echo "backing up old .vimrc"
  mv $homeDir/.vimrc $homeDir/.vimrc_`date +%Y%m%d%H%M`.bak
  ln -s $srcDir/vim/.vimrc $homeDir/.vimrc
fi

if [ ! -L $homeDir/.vim ]; then
  echo "backing up old .vim directory"
  mv $homeDir/.vim $homeDir/.vim_`date +%Y%m%d%H%M`
  ln -s $srcDir/vim/.vim $homeDir/.vim
fi

if [ ! -L $homeDir/.config ]; then
  ln -s $srcDir/.config/dunst $homeDir/.config/dunst
  ln -s $srcDir/.config/i3 $homeDir/.config/i3
  ln -s $srcDir/.config/neofetch $homeDir/.config/neofetch
  ln -s $srcDir/.config/polybar $homeDir/.config/polybar
  ln -s $srcDir/.config/rofi $homeDir/.config/rofi
  ln -s $srcDir/.config/rofi $homeDir/.config/rofi
fi

# reload stuff
source $homeDir/.bashrc

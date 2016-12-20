# Install any OS specific packages
# This assumes Atom is installed (and homebrew on OSX)
case "$(uname -s)" in

  Linux)
    isInstalled=`dpkg-query --show --showformat='${db:Status-Status}\n' 'clang-format'`
    if [ "$isInstalled" != "installed" ]; then
      sudo apt-get install -y clang-format
    fi
  ;;

  # OSX
  Darwin)
    hasClang=`brew list | grep clang-format`
    if [ -z $hasClang ]; then
      brew install clang-format
    fi
  ;;

  # Anything else
  *)
    echo "OS not recognized "
    echo $(uname -s)
  ;;
esac


if [ -d $HOME/.atom ]; then
  echo "Linking atom files..."
  WD=$(pwd)
  cd $HOME/.atom

  # backup and link existing files, only if they aren't already symbolic links
  if [ ! -L config.cson ]; then
    mv config.cson config.cson_`date +%Y%m%d%H%M`.bak ;
    ln -s $WD/config.cson .
  fi

  if [ ! -L init.coffee ]; then
    mv init.coffee init.coffee_`date +%Y%m%d%H%M`.bak ;
    ln -s $WD/init.coffee .
  fi

  if [ ! -L keymap.cson ]; then
    mv keymap.cson keymap.cson_`date +%Y%m%d%H%M`.bak ;
    ln -s $WD/keymap.cson .
  fi

  if [ ! -L snippets.cson ]; then
    mv snippets.cson snippets.cson_`date +%Y%m%d%H%M`.bak ;
    ln -s $WD/snippets.cson .
  fi

  if [ ! -L styles.less ]; then
    mv styles.less styles.less_`date +%Y%m%d%H%M`.bak ;
    ln -s $WD/styles.less .
  fi
fi

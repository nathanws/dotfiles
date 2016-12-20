# skip installing any packages that already installed
installPack() {
  local package=$1
  local atIndex=`expr index "$package" @`

  if [[ $atIndex -gt 0 ]]
  then
    # do not include '@' in the package name
    local end=$((atIndex - 1))
    local newPackage=${package:0:end}

    if [[ ! -d "$HOME/.atom/packages/$newPackage" ]]
    then
      # do not use $newPackage to ensure the specified version of the package is installed
      apm install $package
    else
      echo "$newPackage already installed, skipping..."
    fi
  fi
}

while read in; do installPack "$in"; done < packages.list

# Atom

Config stuff for [Atom](https://atom.io).

## Installing

This assumes Atom is already installed (and [Homebrew](http://brew.sh) on OSX).

### System dependencies and Atom config files

Run `install.sh`.

This will:

1. Install any system specific dependencies (e.g., `clang-format`)
1. Backup any existing Atom config files
1. Symlink Atom config files from this directory into `$HOME/.atom`

### Atom packages

Run `install-packages.sh`.

This will read from `packages.list` and install any packages that are not already installed. It will not update existing packages if they appear in `packages.list`.

## Updating

Any time an Atom preference is changed, it will be reflected in the `config.cson` here.

To update `packages.list`, run `update-package-list.sh`. This will update `packages.list` with all the currently installed packages and their version. This script can also be run to reflect when existing packages are updated to a new version.

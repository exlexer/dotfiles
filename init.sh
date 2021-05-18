#!/usr/bin/env bash

# install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)";

brew update;
brew install neovim;
brew install bat;

rm -rf $HOME/.config/nvim;
mkdir $HOME/.config/nvim;
cp -r ./.config/nvim $HOME/.config/nvim;

#!/usr/bin/env bash

# install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)";

brew update;
brew install neovim;
brew install bat;

mkdir $HOME/.config/nvim;
cp -r $HOME/.config/nvim ./.config/nvim;

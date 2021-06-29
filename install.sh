#!/bin/bash

# install script pattern followed found here: https://github.com/PezCoder/dotfiles

set -e

command_exists () {
  type "$1" &> /dev/null ;
}

is_osx () {
    if [ "$(uname)" == "Darwin" ]; then
        true
    else
        false
    fi
}

installed () {
    echo -e " ✓ $1 already installed."
}

main () {
    cd $HOME
    install_zsh
    install_rg
    install_plug
    install_tmux
    install_tmuxinator
    install_neovim
    install_alacritty

    for i in ${DOTFILES[@]}; do
        link_dotfile $i
    done
}

install_zsh() {
    if !(command_exists zsh); then
        apt-get install zsh --assume-yes
        chsh -s /bin/zsh
    else
        installed 'zsh'
    fi

    DIR="/Users/$USER/.oh-my-zsh"
    if [ ! -d "$DIR" ]; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        rm -rf ~/.zshrc
    else
        installed 'oh-my-zsh'
    fi
}

install_rg() {
    if !(command_exists rg); then
        brew tap burntsushi/ripgrep https://github.com/BurntSushi/ripgrep.git
        brew install burntsushi/ripgrep/ripgrep-bin
    else
        installed 'rg'
    fi
}

install_plug() {
    FILE=".vim/autoload/plug.vim"
    if [ ! -f "$FILE" ]; then
        curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    else
        installed 'Plug'
    fi
}

install_tmux() {
    if !(command_exists tmux); then
        brew install tmux
    else
        installed 'tmux'
    fi
}

install_tmuxinator() {
  if !(command_exists tmuxinator); then
    brew install tmuxinator

    mkdir ~/.config/tmuxinator
    cp ./config/tmuxinator/template.yml ~/.config/tmuxinator/template.yml
  else
    installed 'tmuxinator'
  fi
}

install_neovim() {
    if !(command_exists nvim); then
        brew install neovim/neovim/neovim
        ln -Fs ~/.vim ~/.config/nvim
        ln -Fs ~/.vimrc ~/.config/nvim/init.vim
        ln -Fs ~/"$EXPORT_DIR/config/coc-settings.json" ~/.config/nvim/coc-settings.json
    else
        installed 'neovim'
    fi
}

echo "$EXPORT_DIR"

install_alacritty() {
    FILE="/Applications/Alacritty.app"
    if [ ! -d "$FILE" ]; then
        # clone
        git clone https://github.com/alacritty/alacritty.git
        cd alacritty

        make app
        cp -r target/release/osx/Alacritty.app /Applications/

        # clean
        cd ..
        rm -rf alacritty

        # Symlink config file
        mkdir -p .config/alacritty
        ln -Fs "$EXPORT_DIR/config/alacritty.yml" ~/.config/alacritty/alacritty.yml

        # Enable smoothing on mac
        defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO
        defaults -currentHost write -globalDomain AppleFontSmoothing -int 2
    else
        installed 'alacritty'
    fi
}

link_dotfile() {
  src=$1
  dst=.$1
  rm -rf -f $dst
  ln -Fs $EXPORT_DIR/$src $dst
}

EXPORT_DIR=$(dirname "${PWD}/$0")
DOTFILES=(
  vimrc
  zshrc
  tmux.conf
)

main

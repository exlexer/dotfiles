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
        # https://github.com/ohmyzsh/ohmyzsh#unattended-install
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        # Remove zshrc created by oh-my-zsh by default because we have our own
        rm -rf ~/.zshrc
        # Setup theme in oh-my-zsh
        cp "$EXPORT_DIR/themes/clean-minimal.zsh-theme" ~/.oh-my-zsh/themes/clean-minimal.zsh-theme
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

install_neovim() {
    if !(command_exists nvim); then
        brew install neovim/neovim/neovim
        ln -s ~/.vim ~/.config/nvim
        ln -s ~/.vimrc ~/.config/nvim/init.vim
        ls -s ~/"$EXPORT_DIR/config/coc-settings.json" ~/.vim/coc-settings.json
    else
        installed 'neovim'
    fi
}

install_alacritty() {
    if !(command_exists alacritty); then
        brew cask install alacritty

        # clone
        git clone https://github.com/alacritty/alacritty.git
        cd alacritty

        # Install terminfo globally, I'm thinking this is to make the awesome
        # true colors & italic fonts work
        # We also change default terminal to alacritty in ~/.tmux.conf to use this
        sudo tic -xe alacritty,alacritty-direct extra/alacritty.info

        # clean
        cd ..
        rm -rf alacritty

        # Symlink config file
        mkdir -p .config/alacritty
        ln -s "$EXPORT_DIR/config/alacritty.yml" ~/.config/alacritty/alacritty.yml

        # Enable smoothing on mac
        defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO
        defaults -currentHost write -globalDomain AppleFontSmoothing -int 2
    else
        installed 'alacritty'
    fi
}

main
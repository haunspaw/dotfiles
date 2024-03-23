#!/bin/bash

# Check if the script is run with sudo
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run with sudo."
    exit 1
fi

install_basics() {
    # Install pre-requisites for vim and environment
    apt update && apt install -y \
    dnsutils \
    nmap \
    bastet \
    awscli \
    wget \
    git
    
    echo "Half way there"
    echo "Starting Anaconda step"
    
    # Download Anaconda installer
    wget -q https://repo.anaconda.com/archive/Anaconda3-2024.02-1-Linux-x86_64.sh -O /tmp/anaconda.sh
    
    echo "Run Anaconda"
    # Run Anaconda installer
    bash /tmp/anaconda.sh -b -p /opt/anaconda3 

    # Remove Anaconda installer script
    rm /tmp/anaconda.sh

    echo "Installing Vundle"
    # Clone Vundle repository
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

    echo "Downloading Gotham colorscheme"
    # Download Gotham colorscheme file
    wget https://raw.githubusercontent.com/whatyouhide/vim-gotham/master/colors/gotham.vim -P ~/.vim/colors/

    echo "Updating .vimrc"
    # Update .vimrc to use Gotham colorscheme and include Syntastic plugin
    cat <<EOF >> ~/.vimrc

set nocompatible              " be iMproved, required
filetype off                  " required

# " set the runtime path to include Vundle and initialize
# set rtp+=~/.vim/bundle/Vundle.vim
# call vundle#begin()
# " let Vundle manage Vundle, required
# Plugin 'VundleVim/Vundle.vim'
# Plugin 'scrooloose/syntastic'    " Syntastic plugin
# " Add your other plugins here

# " All of your Plugins must be added before the following line
# call vundle#end()            " required
# filetype plugin indent on    " required

colorscheme gotham
EOF

    echo "Finished installing"
}

git_config() {
    git config --global user.email "aunspaw.3@wright.edu"
    git config --global user.name "Harrison Aunspaw"
    git config --global core.editor nano
}

set_alias() {
echo "alias h='history'" >> ~/.bashrc
echo "alias gl='git log'" >> ~/.bashrc
echo "alias diskspace='du -S | sort -n -r |more'" >> ~/.bashrc
source ~/.bashrc
cp ~/.bashrc ~/dotfiles/.bashrc
}

mkdir -p ~/.ssh
cat <<EOT > ~/.ssh/config
Host fry.cs.wright.edu
    Hostname fry.cs.wright.edu
    User your_username_here
EOT
ln -sf ~/dotfiles/config ~/.ssh/config

set_ln() {
cp ~/.gitconfig ~/dotfiles/.gitconfig
cp ~/.bashrc ~/dotfiles/.bashrc
}

# Call the functions
install_basics
git_config
set_alias
set_ln


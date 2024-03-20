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
    &&

    # Download Anaconda installer
    wget -q https://repo.anaconda.com/archive/Anaconda3-latest-Linux-x86_64.sh -O /tmp/anaconda.sh &&
    
    # Run Anaconda installer
    bash /tmp/anaconda.sh -b -p /opt/anaconda3 &&

    echo "Finished installing"
}

git_config() {
    git config --global user.email "aunspaw.3@wright.edu"
    git config --global user.name "Harrison Aunspaw"
    git config --global core.editor nano
}

# Call the functions
install_basics
git_config

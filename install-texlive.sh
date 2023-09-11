#!/usr/bin/env bash

WORKDIR=$(pwd)
cd /tmp || exit
wget https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz 
zcat < install-tl-unx.tar.gz | tar xf -
cd install-tl-2* || exit
sudo perl ./install-tl --profile="$WORKDIR"/texlive.profile
echo "export PATH=/usr/local/texlive/2023/bin/x86_64-linux:$PATH" >> ~/.bashrc

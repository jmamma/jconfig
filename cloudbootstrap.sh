#!/bin/bash
#Oneliner:
#bash <(curl https://raw.githubusercontent.com/jmamma/jconfig/master/cloudbootstrap.sh)

#Package Install
sudo apt-get update
sudo apt-get install vim git

cd ~
git clone git@github.com:jmamma/jconfig.git

#Config VIM
ln -s ~/jconfig/.vimrc ~/vimrc

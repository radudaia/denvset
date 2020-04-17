#!/bin/bash


# install sublime-text, as instructed here:
# https://tipsonubuntu.com/2017/05/30/install-sublime-text-3-ubuntu-16-04-official-way/
install_sublime-text() {
	# install the GPG key
 	wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1 apt-key add - 2>&1 > /dev/null
 
 	# Ensure apt is set up to work with https sources: 
	sudo apt-get install -y apt-transport-https 2>&1 > /dev/null
 
 	# take stable version
 	echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list 2>&1 > /dev/null
 
 	# update apt sources and install Sublime Text
 	sudo apt-get update 2>&1 > /dev/null
 	sudo apt-get install -y sublime-text 2>&1 > /dev/null
}

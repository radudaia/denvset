#!/bin/bash

################################################################################
#                          Embedded Development Environment                    #
#                                Setup Script                                  #
#                                                                              #
#  Use this script to rapidly deploy basic and desired embedded development    #
#  packages.								                                   #
#  Last revision: 29/03/2020						                           #
#									                                           #
################################################################################
#									                                           #
#  Copyright (C) 2020, Radu Daia, Maze Electronics		   	                   #
#  Contact: radu.daia93@gmail.com				   	                           #
#                     						   	                               #
#  This program is free software; you can redistribute it and/or modify        #
#  it under the terms of the GNU General Public License as published by        #
#  the Free Software Foundation; either version 2 of the License, or           #
#  (at your option) any later version.                                         #
#                                                                              #
#  This program is distributed in the hope that it will be useful,             #
#  but WITHOUT ANY WARRANTY; without even the implied warranty of              #
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the               #
#  GNU General Public License for more details.                                #
#                                                                              #
################################################################################

# packages considered essential for embedded development


# basic packages for embedded development
AVRPackages="avr-gcc"

ARMPackages="\
	libc6-armel-cross \
	libc6-dev-armel-cross \
	binutils-arm-linux-gnueabi \
	libncurses5-dev \
	"

IntelPackages="\
	gcc \
	g++ \
	"

MakePackages="\
	make \
	cmake\
	"

EditorPackages="\
	vim \
	sublime-text\
	"

TerminalPackages="terminator"

SourceControlPackages="\
	git \
	svn\
	"

ExtraDebugPackages="valgrind"

EmbeddedBasicPackages="\
	$IntelPackages \
	$AVRPackages \
	$ARMPackages \
	$MakePackages \
	$EditorPackages \
	$TerminalPackages \
	$SourceControlPackages \
	$ExtraDebugPackages \
	"

# extra fancy software to install
BrowserPackages="chromium-browser"
IDEPackages="pycharm-community"

PACKAGES="\
	$EmbeddedBasicPackages \
	$BrowserPackages \
	$IDEPackages \
	"

# TODO: extend install possibilities for 
# other package managers besides apt

install_package() {
	yes | sudo apt install $1
}

update () {
	sudo apt update
}

install_sublime() {

	# install the GPG key
	wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -

	# Ensure apt is set up to work with https sources: 
	install_package apt-transport-https

	# take stable version
	echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

	# update apt sources and install Sublime Text
	update
	install_package sublime-text
}

install_pycharm() {

	# install PyCharm Community :)
	yes | sudo snap install pycharm-community --classic
}

install_packages() {
	echo "List of packages:"
	echo $PACKAGES
	for p in $PACKAGES; do
		if [ "$p" == "sublime-text" ]; then
			install_sublime
		elif [ "$p" == "pycharm-community" ]; then
			install_pycharm
		else
			install_package $p
		fi
	done
}

main () {
	# install desired packages
	install_packages
}

# do the magic
main

#!/bin/bash

# Essential packages for Yocto, as instructed here:
# https://www.yoctoproject.org/docs/2.0/yocto-project-qs/yocto-project-qs.html
BASE_YOCTO="\
	gawk \
	wget \
        git-core \
       	diffstat \
	unzip \
	texinfo \
	gcc-multilib \
	build-essential \
	chrpath \
	socat \
	libsdl1.2-dev \
	xterm \
	"

EXCEPTION_YOCTO=""

YOCTO="${BASE_YOCTO} ${EXCEPTION_YOCTO}"

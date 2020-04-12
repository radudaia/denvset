#!/bin/bash

# ARM development essentials :)
BASE_ARM="\
	libc6-armel-cross \
	libc6-dev-armel-cross \
	binutils-arm-linux-gnueabi \
	libncurses5-dev \
	"

EXCEPTION_ARM=""

ARM="${BASE_ARM} ${EXCEPTION_ARM}"


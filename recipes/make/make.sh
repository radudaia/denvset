#!/bin/bash

# *make tools
BASE_MAKE="\
	make \
	cmake \
	"

EXCEPTION_MAKE=""

MAKE="${BASE_MAKE} ${EXCEPTION_MAKE}"

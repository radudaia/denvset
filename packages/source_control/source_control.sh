#!/bin/bash

# version control systems
BASE_SOURCE_CONTROL="\
	git \
	svn \
	"

EXCEPTION_SOURCE_CONTROL=""

SOURCE_CONTROL="${BASE_SOURCE_CONTROL} ${EXCEPTION_SOURCE_CONTROL}"

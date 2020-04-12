#!/bin/bash

BASE_DEBUG="\
	valgrind \
	"

EXCEPTION_DEBUG=""

DEBUG="${BASE_DEBUG} ${EXCEPTION_DEBUG}"

#!/bin/bash

IDES_EXCEPTIONS="\
	pycharm-community \
	"

install_pycharm-community() {
	sudo snap install pycharm-community --classic
}

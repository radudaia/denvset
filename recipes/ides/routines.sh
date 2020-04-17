#!/bin/bash

install_pycharm-community() {
	export SNAPDIR=/tmp
	sudo snap install pycharm-community --classic | grep -q "pycharm"
}

#!/bin/bash

RECIPES_DIR="packages"

RECIPES_LIST="\
	arm \
	browsers \
	debug \
	editors \
	ides \
	intel \
	make \
	source_control \
	terminals \
	yocto \
	"

PACKAGES_LIST=""
for recipe in ${RECIPES_LIST}
do
	. ./${RECIPES_DIR}/${recipe}/${recipe}.sh
	recipe_val=${recipe^^}
	PACKAGES_LIST="${PACKAGES_LIST} ${!recipe_val}"
done

echo ${PACKAGES_LIST}

sudo apt-get update

for package in ${PACKAGES_LIST}
do
	sudo apt-get -y install ${package} 2>&1 > /dev/null
done


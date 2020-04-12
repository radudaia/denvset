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
	# source recipes
	. ./${RECIPES_DIR}/${recipe}/recipe

	exceptions_list_name="${recipe^^}_EXCEPTIONS"
	exceptions_list=${!exceptions_list_name}
	exceptions_count=$(echo "${exceptions_list}" | wc -w)

	# if packages that need special installation steps
	# are required, then source file with routines to
	# handle them
	if [ $exceptions_count -gt 0 ]; then
		. ./${RECIPES_DIR}/${recipe}/routines
	fi

	recipe_val=${recipe^^}
	PACKAGES_LIST="${PACKAGES_LIST} ${!recipe_val}"
done

echo ${PACKAGES_LIST}

sudo apt-get update

for package in ${PACKAGES_LIST}
do
	sudo apt-get -y install ${package} 2>&1 > /dev/null
done



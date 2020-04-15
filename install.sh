#!/bin/bash

################################################################################
#                          Embedded Development Environment                    #
#                                Setup Script                                  #
#                                                                              #
#  Use this script to rapidly deploy basic and desired embedded development    #
#  packages.								                                   #
#  Last revision: 15/04/2020						                           #
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

	exceptions_list_name="EXCEPTION_${recipe^^}"
	exceptions_list=${!exceptions_list_name}
	exceptions_count=$(echo "${exceptions_list}" | wc -w)

	# if packages that need special installation steps
	# are required, then source file with routines to
	# handle them
	if [ $exceptions_count -gt 0 ]; then
		. ./${RECIPES_DIR}/${recipe}/routines
		#echo "Sourced routines for ${recipe}"
	fi

	recipe_val=${recipe^^}
	recipe_base_packages="BASE_${recipe_val}"
	recipe_exception_packages="EXCEPTION_${recipe_val}"
	#echo "${!recipe_val}"
	#echo "recipe_base_packages=${!recipe_base_packages}"
	for package in ${!recipe_val}
	do
		if [[ ${!recipe_base_packages} == *"${package}"*  ]]; then
			BASE_PACKAGES="${BASE_PACKAGES} ${package}"
			#echo "${package} added in BASE"
		else
			EXCEPTION_PACKAGES="${EXCEPTION_PACKAGES} ${package}"
			#echo "${package} added in EXCEPTION"
		fi
	done
done

sudo apt-get update

# install the trivial packages
for package in ${BASE_PACKAGES}
do
	sudo apt-get -y install ${package} 2>&1 > /dev/null
done

# install the more difficult packages
for package in ${EXCEPTION_PACKAGES}
do
	echo "Preparing to install ${package}"
	install_${package}
done

#!/bin/bash

################################################################################
#                          Embedded Development Environment                    #
#                                Setup Script                                  #
#                                                                              #
#  Use this script to rapidly deploy basic and desired embedded development    #
#  packages.								       #
#  Last revision: 15/04/2020						       #
#									       #
################################################################################
#									       #
#  Copyright (C) 2020, Radu Daia, Maze Electronics		   	       #
#  Contact: radu.daia93@gmail.com				   	       #
#                     						   	       #
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

RECIPES_DIR="recipes"

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

. ./utils.sh


printf "${cyn}[INFO]${end} ${mag}DEnvSet is starting up!${end}\n"
printf "${cyn}[INFO]${end} ${mag}Parsing recipes...${end}"
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
	fi

	recipe_val=${recipe^^}
	recipe_base_packages="BASE_${recipe_val}"
	recipe_exception_packages="EXCEPTION_${recipe_val}"
	for package in ${!recipe_val}
	do
		if [[ ${!recipe_base_packages} == *"${package}"*  ]]; then
			BASE_PACKAGES="${BASE_PACKAGES} ${package}"
		else
			EXCEPTION_PACKAGES="${EXCEPTION_PACKAGES} ${package}"
		fi
	done
done
printf "${grn}[DONE]${end}\n"

printf "${cyn}[INFO]${end} ${mag}Updating aptitude package manager.....${end}"
sudo apt-get update 2>&1 > /dev/null
printf "${grn}[DONE]${end}\n"


line="..............................."
arrow="|---->"

PACKAGES="${BASE_PACKAGES} ${EXCEPTION_PACKAGES}"

packages_count=$(echo "${PACKAGES}" | wc -w)
current_progress=0
progress_step=$(echo "scale=2; 100/${packages_count}" | bc)

printf "${cyn}[INFO]${end} ${blu}Installing package(s):${end}\n"
# install the trivial packages
for package in ${BASE_PACKAGES}
do
	printf "${cyn}[INFO]${end} ${blu}${arrow}${end} ${yel}${package}${end}${line:${#package}}"
	sudo apt-get -y install ${package} 2>&1 > /dev/null
	current_progress=$(echo "scale=2; ${current_progress} + ${progress_step}" | bc)
	printf "${grn}[DONE]${end}${red}[${current_progress}%%]${end}\n"
done

# install the more difficult packages
for package in ${EXCEPTION_PACKAGES}
do
	printf "${cyn}[INFO]${end} ${blu}${arrow}${end} ${yel}${package}${end}${line:${#package}}"
	install_${package}
	current_progress=$(echo "scale=2; ${current_progress} + ${progress_step}" | bc)
	printf "${grn}[DONE]${end}${red}[${current_progress}%%]${end}\n"
done

success_message="All packages installed!"
printf "${cyn}[INFO]${end} ${blu}\\----- ${success_message}${end}${line:${#success_message}}${red}      [100.0%%]${end}\n"

echo "${cyn}[INFO]${end} ${mag}System setup finished successfully!${end}"

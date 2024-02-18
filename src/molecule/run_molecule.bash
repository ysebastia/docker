#!/bin/bash
set -e

NOCOLOR='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'

function run_test()
{
	local directory="${1}"
	local type="${2}"
	
	if [ ! -d "${directory}" ];
	then
		echo -e "| ${RED}Dossier ${directory} non présent${NOCOLOR}"
		exit 1
	fi
	
	for roledir in "${directory}"/*/molecule; do
		echo -e "| ${GREEN}Test ${type} ${roledir}${NOCOLOR}"
	    pushd "$(dirname "${roledir}")" || exit 2
	    molecule test
	    popd || exit 2
	done
}

function Help()
{
   # Display Help
   echo "Execution des tests molecule du dossier courant."
   echo
   echo "Syntax: run_molecule [-h|-r|-p]"
   echo "options:"
   echo "-h  Affichage de cette aide."
   echo "-r  Analyse des rôles."
   echo "-p  Analyse des playbooks."
   echo
}

for arg in "$@" ; do
   shift
   case "$arg" in
      -h)
		Help
		exit
		;;
      -r) # Analyse des rôles
         target="roles"
         message="ROLE"
         ;;
      -p) # Analyse des playbooks
         target="tests"
         message="PLAYBOOK"
         ;;
      *)
         echo "Error: Invalid option"
         exit 2
         ;;
   esac
done


# Identification du dossier de la collection
dir_role="$(find . -name galaxy.yml -exec dirname {} \;)"
cd "${dir_role}" || exit 2

run_test "${target}" "${message}"

exit 0
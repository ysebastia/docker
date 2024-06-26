#!/bin/bash
set -e

NOCOLOR='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'

for arg in "$@" ; do
   shift
   case "$arg" in
      -h)
		Help
		exit
		;;
      -r) # Analyse des rôles
         source="roles"
         molecule="roles"
         type="d"
         ;;
      -p) # Analyse des playbooks
         source="playbooks"
         molecule="tests/playbooks"
         type="f"
         ;;
      *)
         echo "Error: Invalid option"
         exit 2
         ;;
   esac
done

nb_collection=$(find . -name galaxy.yml|wc -l)
declare -i sum_coverage=0

function fake_coverage()
{
    echo "Collection ${dir_collection}"
    
    nb_source=$(find "${dir_collection}/${source}/" -maxdepth 1 -type "${type}" | grep -vc "/$")
    nb_molecule=$(find "${dir_collection}/${molecule}/" -name molecule.yml -type f | wc -l)    
    
    if [ "${nb_source}" -gt 0 ]; then
        coverage=$(echo "scale=0;$nb_molecule * 100 / $nb_source" | bc)
    else
        coverage=0
    fi
    sum_coverage=$(echo "$sum_coverage + $coverage" | bc)

    for i in $(find "${dir_collection}/${source}/" -maxdepth 1 -type "${type}" | grep -v "/$" | sort);
    do
        item="$(echo "${i}" | awk -F '/' '{print $NF}' | awk -F '.' '{print $1}')"
        if [ -d "${dir_collection}/${molecule}/${item}" ] && [ "$(find "${dir_collection}/${molecule}/${item}" -name molecule.yml -type f | wc -l)" -eq 1 ]; then
            echo -e "${GREEN}Test ${source}/${item} : OK${NOCOLOR}"
        else
            echo -e "${RED}Test ${source}/${item} : KO${NOCOLOR}"
        fi;
    done;
    
    echo "Collection coverage: ${coverage}" 
    echo ""
}

while IFS= read -r -d '' line; do 
    dir_collection=$(dirname "${line}")
    if [ -d "${dir_collection}/${molecule}/" ]; then
        fake_coverage
    else
        echo -e "${ORANGE}Missing directory ${dir_collection}/${molecule}${NOCOLOR}"
    fi    
done < <(find . -name galaxy.yml -print0)

overall_coverage=$(echo "scale=0;$sum_coverage / $nb_collection" | bc)

echo "Code coverage: ${overall_coverage}" 
    
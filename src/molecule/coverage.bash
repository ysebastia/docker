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
         begin_with='name: "'
         end_with='"$'
         type="d"
         ;;
      -p) # Analyse des playbooks
         source="playbooks"
         begin_with='.import_playbook: '
         end_with='$'
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
    nb_molecule=0    
    

    for i in $(find "${dir_collection}/${source}/" -maxdepth 1 -type "${type}" | grep -v "/$" | sort);
    do
        item="$(echo "${i}" | awk -F '/' '{print $NF}' | awk -F '.' '{print $1}')"
        fqcn="${begin_with}$(echo ${dir_collection} | rev | awk -F '/' '{print $1"."$2}' | rev).${item}${end_with}"
        nb_call="$(grep -rlE "${fqcn}" "${dir_collection}/extensions/molecule" | wc -l)"
        if [[ "${nb_call}" -gt 0 ]]; then
            echo -e "${GREEN}Test ${source}/${item} : OK (${nb_call})${NOCOLOR}"
            nb_molecule=$((nb_molecule + 1))
        else
            echo -e "${RED}Test ${source}/${item} : KO${NOCOLOR}"
        fi;
    done;
    
    if [[ "${nb_source}" -gt 0 ]]; then
        coverage=$(echo "scale=0;$nb_molecule * 100 / $nb_source" | bc)
    else
        coverage=0
    fi
    sum_coverage=$(echo "$sum_coverage + $coverage" | bc)

    echo "Collection coverage: ${coverage}" 
    echo ""
}

while IFS= read -r -d '' line; do 
    dir_collection=$(dirname "${line}")
    if [[ -d "${dir_collection}/extensions/molecule/" ]]; then
        fake_coverage
    else
        echo -e "${ORANGE}Missing directory ${dir_collection}/extensions/molecule${NOCOLOR}"
    fi    
done < <(find . -name galaxy.yml -print0)

overall_coverage=$(echo "scale=0;$sum_coverage / $nb_collection" | bc)

echo "Code coverage: ${overall_coverage}" 
    
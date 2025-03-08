#!/bin/bash
set -e
export ANSIBLE_COLLECTIONS_PATH="~/.ansible/collections/:./collections"
NOCOLOR='\033[0m'
GREEN='\033[0;32m'

find . -name molecule.yml -print0 | 
    while IFS= read -r -d '' line; do
        dir_role=$(dirname "${line}")
        scenario=$(echo "${dir_role}" | awk -F '/' '{print $NF}')
		echo -e "| ${GREEN}Test ${dir_role}${NOCOLOR}"
        pushd "${dir_role}/../../" || exit 2
        molecule test -s "${scenario}"
        popd || exit 2
    done

exit 0
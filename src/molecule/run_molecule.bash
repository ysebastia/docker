#!/bin/bash
set -e

NOCOLOR='\033[0m'
GREEN='\033[0;32m'

find . -name molecule.yml -print0 | 
    while IFS= read -r -d '' line; do
        dir_role=$(dirname "${line}")
		echo -e "| ${GREEN}Test ${roledir}${NOCOLOR}"
        pushd "${dir_role}/../../" || exit 2
        molecule list
        popd || exit 2
    done

exit 0
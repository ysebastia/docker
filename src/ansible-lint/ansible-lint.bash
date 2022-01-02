#!/bin/sh
find "${1}" -type f -name "*.yml" -exec ansible-lint -p {} \; | sort -n | uniq
exit 0
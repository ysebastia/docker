#!/bin/sh
find "${1}" -type f |file -i -F "::" -f - | awk -v FILETYPE="text/x-shellscript;"  -F"::" '$2 ~ FILETYPE { print $1 }' | xargs shellcheck -f checkstyle
exit 0
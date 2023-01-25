#!/bin/sh
find "${1}" -type f -iname "dockerfile" -print | xargs hadolint -f checkstyle | xmlstarlet tr /usr/local/share/checkstyle2junit.xslt
exit 0

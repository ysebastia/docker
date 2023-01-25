#!/bin/sh
find "${1}" -type f -iname "dockerfile" -print | xargs hadolint -f json
exit 0

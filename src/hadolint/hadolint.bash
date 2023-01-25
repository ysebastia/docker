#!/bin/sh
find "${1}" -type f -iname "dockerfile" | xargs hadolint -f json
exit 0

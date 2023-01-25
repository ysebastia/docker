#!/bin/sh
git ls-files | grep -i dockerfile | xargs hadolint -f json
exit 0

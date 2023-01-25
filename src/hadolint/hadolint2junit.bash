#!/bin/sh
git ls-files | grep -i dockerfile | xargs hadolint -f checkstyle | xmlstarlet tr /usr/local/share/checkstyle2junit.xslt
exit 0

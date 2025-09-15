FROM docker.io/hadolint/hadolint:2.13.1-alpine
RUN apk add --no-cache \
  git=2.34.8-r0 \
  xmlstarlet=1.6.1-r0
COPY checkstyle2junit.xslt /usr/local/share/
COPY hadolint2junit.bash /usr/local/bin/
COPY hadolint.bash /usr/local/bin/
RUN chmod +x /usr/local/bin/*.bash

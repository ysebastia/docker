FROM docker.io/hadolint/hadolint:v2.14.0-alpine
RUN apk add --no-cache \
  git=2.49.1-r0 \
  xmlstarlet=1.6.1-r2
COPY checkstyle2junit.xslt /usr/local/share/
COPY hadolint2junit.bash /usr/local/bin/
COPY hadolint.bash /usr/local/bin/
RUN chmod +x /usr/local/bin/*.bash

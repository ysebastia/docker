FROM alpine:20250108
RUN apk add --no-cache \
  file=5.46-r2 \
  git=2.50.1-r0 \
  shellcheck=0.10.0-r2 \
  xmlstarlet=1.6.1-r2
COPY checkstyle2junit.xslt /usr/local/share/
COPY shellcheck.bash /usr/local/bin/
COPY shellcheck2junit.bash /usr/local/bin/
RUN chmod +x /usr/local/bin/*.bash
CMD ["/usr/bin/shellcheck"]

FROM alpine:3.24.1
RUN apk add --no-cache \
  file=5.47-r2 \
  git=2.54.0-r0 \
  shellcheck=0.11.0-r1 \
  xmlstarlet=1.6.1-r2
COPY checkstyle2junit.xslt /usr/local/share/
COPY shellcheck.bash /usr/local/bin/
COPY shellcheck2junit.bash /usr/local/bin/
RUN chmod +x /usr/local/bin/*.bash
CMD ["/usr/bin/shellcheck"]

FROM alpine:20230901
RUN apk add --no-cache \
  file=5.45-r1 \
  git=2.44.0-r0 \
  shellcheck=0.10.0-r0 \
  xmlstarlet=1.6.1-r2
COPY checkstyle2junit.xslt /usr/local/share/
COPY shellcheck.bash /usr/local/bin/
COPY shellcheck2junit.bash /usr/local/bin/
RUN chmod +x /usr/local/bin/*.bash
CMD ["/usr/bin/shellcheck"]

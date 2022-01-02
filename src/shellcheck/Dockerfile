FROM alpine:3.15.0
RUN apk add --no-cache \
	shellcheck=0.7.2-r2 \
	file=5.41-r0
COPY shellcheck.bash /usr/local/bin/
RUN chmod +x /usr/local/bin/shellcheck.bash
CMD ["/usr/bin/shellcheck"]
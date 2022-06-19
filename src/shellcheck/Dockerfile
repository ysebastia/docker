FROM alpine:3.16.0
RUN apk add --no-cache \
	shellcheck=0.8.0-r0 \
	file=5.41-r0
COPY shellcheck.bash /usr/local/bin/
RUN chmod +x /usr/local/bin/shellcheck.bash
CMD ["/usr/bin/shellcheck"]
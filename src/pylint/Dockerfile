FROM alpine:3.15.0
RUN apk add --no-cache \
	py3-pylint=2.10.2-r1 \
	file=5.41-r0
RUN mkdir -p /root/.cache/pylint
CMD ["/usr/bin/pylint"]
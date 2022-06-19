FROM alpine:3.16.0
RUN apk add --no-cache \
	py3-pylint=2.12.2-r0 \
	file=5.41-r0 \
	&& mkdir -p /root/.cache/pylint /.cache/pylint \
	&& chmod 777 /root/.cache/pylint /.cache/pylint
CMD ["/usr/bin/pylint"]
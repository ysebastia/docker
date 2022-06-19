FROM alpine:3.16.0
RUN apk add --no-cache ansible-lint=6.2.1-r0 \
	yamllint=1.26.3-r1 \
	py3-jsonschema=4.5.1-r0 \
	&& mkdir -p /.cache /.ansible \
	&& chmod 777 /.cache /.ansible
CMD ["/usr/bin/ansible-lint"]
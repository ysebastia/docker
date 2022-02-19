FROM php:7.4.28-cli-alpine3.15
RUN apk add --no-cache ca-certificates=20211220-r0 wget=1.21.2-r2
RUN wget -q https://phar.phpunit.de/phpcpd-6.0.3.phar \
	&& mv phpcpd-6.0.3.phar /usr/local/bin/phpcpd \
	&& chmod +x /usr/local/bin/phpcpd
CMD ["/usr/local/bin/phpcpd"]
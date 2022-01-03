FROM php:7.4.27-cli-alpine3.15
RUN apk add --no-cache wget=1.21.2-r2
RUN wget -q --no-check-certificate https://phar.phpunit.de/phpcpd-6.0.3.phar \
	&& mv phpcpd-6.0.3.phar /usr/local/bin/phpcpd \
	&& chmod +x /usr/local/bin/phpcpd
CMD ["/usr/local/bin/phpcpd"]
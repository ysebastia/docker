FROM php:8.1.7-cli-alpine3.16
RUN apk add --no-cache ca-certificates=20211220-r0 wget=1.21.3-r0
RUN wget -q https://github.com/squizlabs/PHP_CodeSniffer/releases/download/3.7.1/phpcs.phar \
	&& mv phpcs.phar /usr/local/bin/phpcs \
	&& chmod +x /usr/local/bin/phpcs
CMD ["/usr/local/bin/phpcs"]
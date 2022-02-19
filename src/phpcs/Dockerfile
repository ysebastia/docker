FROM php:7.4.28-cli-alpine3.15
RUN apk add --no-cache ca-certificates=20211220-r0 wget=1.21.2-r2
RUN wget -q https://github.com/squizlabs/PHP_CodeSniffer/releases/download/3.6.2/phpcs.phar \
	&& mv phpcs.phar /usr/local/bin/phpcs \
	&& chmod +x /usr/local/bin/phpcs
CMD ["/usr/local/bin/phpcs"]
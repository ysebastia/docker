FROM php:7.4.28-cli-alpine3.15
RUN apk add --no-cache ca-certificates=20211220-r0 wget=1.21.2-r2
RUN wget -q https://github.com/phpmd/phpmd/releases/download/2.11.1/phpmd.phar \
	&& mv phpmd.phar /usr/local/bin/phpmd \
	&& chmod +x /usr/local/bin/phpmd
CMD ["/usr/local/bin/phpmd"]
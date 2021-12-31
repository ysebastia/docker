FROM debian:11.1-slim

RUN apt-get update && \
  	apt-get install -y --no-install-recommends \
    cloc=1.86-1 \
    && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/usr/bin/cloc"]
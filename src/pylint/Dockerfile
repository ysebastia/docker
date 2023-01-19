FROM alpine:20221110
RUN apk add --no-cache \
  py3-filelock=3.8.2-r0 \
  py3-pip=22.3.1-r2 \
  py3-wheel=0.38.4-r1 \
  && pip install --no-cache-dir \
  pylint==2.15.10 \
  && find /usr/lib/ -name '*.pyc' -delete
CMD ["/usr/bin/pylint"]

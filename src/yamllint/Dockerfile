FROM alpine:20221110
RUN apk add --no-cache \
  py3-filelock=3.8.2-r0 \
  py3-pip=22.3.1-r2 \
  && pip install --no-cache-dir \
  yamllint==1.29.0 \
  yamllint-junit==0.9 \
  && find /usr/lib/ -name '*.pyc' -delete
CMD ["/usr/bin/yamllint"]

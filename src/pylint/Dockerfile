FROM alpine:20221110
ENV VIRTUAL_ENV=/opt/venv
RUN apk add --no-cache \
  py3-filelock=3.8.2-r0 \
  py3-pip=23.0-r1 \
  py3-virtualenv=20.19.0-r0 \
  py3-wheel=0.38.4-r1 \
  && python3 -m venv /opt/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN pip install --no-cache-dir --upgrade pip==23.0 \
  && pip install --no-cache-dir --use-pep517 \
  pylint==2.16.2 \
  && find /usr/lib/ -name '*.pyc' -delete
CMD ["/opt/venv/bin/pylint"]

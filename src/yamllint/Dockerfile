FROM alpine:20230329
ENV VIRTUAL_ENV=/venv
RUN apk add --no-cache \
  py3-filelock=3.12.0-r1 \
  py3-pip=23.2-r0 \
  py3-virtualenv=20.23.1-r0 \
  py3-wheel=0.40.0-r1 \
  && python3 -m venv /venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN pip install --no-cache-dir --upgrade pip==23.1.2 \
  && pip install --no-cache-dir \
  yamllint==1.32.0 \
  yamllint-junit==0.10.1 \
  && find /usr/lib/ -name '*.pyc' -delete
CMD ["/venv/bin/yamllint"]

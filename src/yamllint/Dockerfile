FROM alpine:20230329
ENV VIRTUAL_ENV=/opt/venv
RUN apk add --no-cache \
  py3-filelock=3.8.2-r0 \
  py3-pip=23.0.1-r0 \
  py3-virtualenv=20.21.0-r0 \
  && python3 -m venv /opt/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN pip install --no-cache-dir --upgrade pip==23.0.1 \
  && pip install --no-cache-dir \
  yamllint==1.30.0 \
  yamllint-junit==0.10.1 \
  && find /usr/lib/ -name '*.pyc' -delete
CMD ["/opt/venv/bin/yamllint"]

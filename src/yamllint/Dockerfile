FROM docker.io/ysebastia/python:3.12.10
RUN pipx install yamllint==1.37.1 \
  && pipx install yamllint-junit==0.10.1
CMD ["/root/.local/bin/yamllint"]

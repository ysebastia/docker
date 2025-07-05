all: pip ansible ansible-builder molecule ansible-lint molecule_os other

ansible:
	podman build --no-cache src/ansible -t docker.io/ysebastia/ansible:2.18.6

ansible-builder:
	podman build --no-cache src/ansible-builder -t docker.io/ysebastia/ansible-builder

ansible-lint:
	podman build --no-cache src/ansible-lint -t docker.io/ysebastia/ansible-lint

molecule:
	podman build --no-cache src/molecule -t docker.io/ysebastia/molecule

molecule_os:
	podman build --no-cache src/molecule-redhat --build-arg https_proxy=$HTTPS_PROXY --build-arg http_proxy=${HTTP_PROXY} --build-arg BASE_OS=registry.access.redhat.com/ubi9/ubi --build-arg VERSION_OS=9.6 -t docker.io/ysebastia/molecule:rhel-9.6
	podman build --no-cache src/molecule-redhat --build-arg https_proxy=$HTTPS_PROXY --build-arg http_proxy=${HTTP_PROXY} --build-arg BASE_OS=registry.access.redhat.com/ubi10/ubi --build-arg VERSION_OS=10.0 -t docker.io/ysebastia/molecule:rhel-10.0
	podman build --no-cache src/molecule-ubuntu --build-arg https_proxy=$HTTPS_PROXY --build-arg http_proxy=${HTTP_PROXY} --build-arg BASE_OS=ubuntu --build-arg VERSION_OS=noble -t docker.io/ysebastia/molecule:noble
	podman build --no-cache src/molecule-ubuntu --build-arg https_proxy=$HTTPS_PROXY --build-arg http_proxy=${HTTP_PROXY} --build-arg BASE_OS=ubuntu --build-arg VERSION_OS=jammy -t docker.io/ysebastia/molecule:jammy
	podman build --no-cache src/molecule-debian --build-arg https_proxy=$HTTPS_PROXY --build-arg http_proxy=${HTTP_PROXY} -t docker.io/ysebastia/molecule:debian-12.11

pip:
	podman build --no-cache src/pip-venv/alpine -t docker.io/ysebastia/pip-venv:25.1.1-alpine
	podman build --no-cache src/pip-venv/debian -t docker.io/ysebastia/pip-venv:25.1.1-debian
	podman build --no-cache src/python -t docker.io/ysebastia/python:3.12.10
	podman build --no-cache src/pylint -t docker.io/ysebastia/pylint:3.3.7
	podman build --no-cache src/yamllint -t docker.io/ysebastia/yamllint:1.37.1
	podman build --no-cache src/checkov -t docker.io/ysebastia/checkov:3.2.413

other: dmarc wget cloc doxygen helm make shellcheck tflint trivy

doxygen:
	podman build --no-cache src/doxygen -t docker.io/ysebastia/doxygen

helm:
	podman build --no-cache src/helm -t docker.io/ysebastia/helm

make:
	podman build --no-cache src/make -t docker.io/ysebastia/make

shellcheck:
	podman build --no-cache src/shellcheck -t docker.io/ysebastia/shellcheck

tflint:
	podman build --no-cache src/tflint -t docker.io/ysebastia/tflint

trivy:
	podman build --no-cache src/trivy -t docker.io/ysebastia/trivy

cloc:
	podman build --no-cache src/cloc -t docker.io/ysebastia/cloc

wget:
	podman build --no-cache src/wget -t docker.io/ysebastia/wget:1.25.0-r2

dmarc:
	podman build --no-cache src/dmarcts-report-parser -t docker.io/ysebastia/dmarcts-report-parser:master-bookworm-slim
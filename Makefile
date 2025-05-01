all: pip ansible ansible-builder molecule ansible-lint other

ansible:
	podman build src/ansible -t docker.io/ysebastia/ansible:2.18.4

ansible-builder:
	podman build src/ansible-builder -t docker.io/ysebastia/ansible-builder

ansible-lint:
	podman build src/ansible-lint -t docker.io/ysebastia/ansible-lint

molecule:
	podman build src/molecule -t docker.io/ysebastia/molecule

pip:
	podman build src/pip-venv/alpine -t docker.io/ysebastia/pip-venv:25.1-alpine
	podman build src/pip-venv/centos -t docker.io/ysebastia/pip-venv:25.1-centos
	podman build src/pip-venv/debian -t docker.io/ysebastia/pip-venv:25.1-debian
	podman build src/python -t docker.io/ysebastia/python:3.12.10
	podman build src/pylint -t docker.io/ysebastia/pylint:3.3.6
	podman build src/yamllint -t docker.io/ysebastia/yamllint:1.37.0
	podman build src/checkov -t docker.io/ysebastia/checkov:3.2.413

other: dmarc wget

wget:
	podman build src/wget -t docker.io/ysebastia/wget:1.25.0-r1

dmarc:
	podman build src/dmarcts-report-parser -t docker.io/ysebastia/dmarcts-report-parser:master-bookworm-slim
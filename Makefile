all: pip ansible ansible-builder molecule ansible-lint other

ansible:
	docker build --progress=plain src/ansible -t ysebastia/ansible:2.18.4

ansible-builder:
	docker build --progress=plain src/ansible-builder -t ysebastia/ansible-builder

ansible-lint:
	docker build --progress=plain src/ansible-lint -t ysebastia/ansible-lint

molecule:
	docker build --progress=plain src/molecule -t ysebastia/molecule

pip:
	podman build src/pip-venv/alpine -t ysebastia/pip-venv:25.1-alpine
	podman build src/pip-venv/centos -t ysebastia/pip-venv:25.1-centos
	podman build src/pip-venv/debian -t ysebastia/pip-venv:25.1-debian
	podman build src/python -t ysebastia/python:3.12.9
	podman build src/pylint -t ysebastia/pylint:3.3.5
	podman build src/yamllint -t ysebastia/yamllint:1.37.0
	podman build src/checkov -t ysebastia/checkov:3.2.377

other: dmarc curl

wget:
	podman build src/wget -t ysebastia/wget:1.25.0-r1

dmarc:
	podman build src/dmarcts-report-parser -t ysebastia/dmarcts-report-parser:master-bookworm-slim
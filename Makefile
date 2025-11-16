all: pip ansible ansible-builder molecule ansible-lint molecule_os other

ansible:
	podman build --no-cache src/ansible -t docker.io/ysebastia/ansible:2.20.0

ansible-builder:
	podman build --no-cache src/ansible-builder -t docker.io/ysebastia/ansible-builder

ansible-lint:
	podman build --no-cache src/ansible-lint -t docker.io/ysebastia/ansible-lint

molecule:
	podman build --no-cache src/molecule --build-arg HTTPS_PROXY=$(HTTP_PROXY) --build-arg HTTP_PROXY=$(HTTP_PROXY) --security-opt label=disable -t docker.io/ysebastia/molecule

molecule_os:
	podman build --no-cache src/molecule-redhat --build-arg HTTPS_PROXY=$(HTTP_PROXY) --build-arg HTTP_PROXY=$(HTTP_PROXY) --security-opt label=disable --build-arg BASE_OS=registry.access.redhat.com/ubi9/ubi --build-arg VERSION_OS=9.6 -t docker.io/ysebastia/molecule:rhel-9.6
	podman build --no-cache src/molecule-redhat --build-arg HTTPS_PROXY=$(HTTP_PROXY) --build-arg HTTP_PROXY=$(HTTP_PROXY) --security-opt label=disable --build-arg BASE_OS=registry.access.redhat.com/ubi10/ubi --build-arg VERSION_OS=10.0 -t docker.io/ysebastia/molecule:rhel-10.0
	podman build --no-cache src/molecule-debian --build-arg HTTPS_PROXY=$(HTTP_PROXY) --build-arg HTTP_PROXY=$(HTTP_PROXY) --security-opt label=disable -t docker.io/ysebastia/molecule:debian-13.1

pip:
	podman build --no-cache src/pip-venv/alpine -t docker.io/ysebastia/pip-venv:25.3-alpine
	podman build --no-cache src/pip-venv/debian -t docker.io/ysebastia/pip-venv:25.3-debian
	podman build --no-cache src/python -t docker.io/ysebastia/python:3.12.10
	podman build --no-cache src/pylint -t docker.io/ysebastia/pylint:3.3.7
	podman build --no-cache src/yamllint -t docker.io/ysebastia/yamllint:1.37.1
	podman build --no-cache src/checkov -t docker.io/ysebastia/checkov:3.2.451

other: wget cloc helm make shellcheck tflint trivy hadolint

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

hadolint:
	podman build --no-cache src/hadolint -t docker.io/ysebastia/hadolint:2.14.0
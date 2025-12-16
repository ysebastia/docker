all: python ansible ansible-builder molecule ansible-lint molecule_os other

ansible:
	podman build --no-cache src/python --build-arg HTTPS_PROXY=$(HTTP_PROXY) --build-arg HTTP_PROXY=$(HTTP_PROXY) --security-opt label=disable --target ansible -t docker.io/ysebastia/ansible:2.20.1

ansible-builder:
	podman build --no-cache src/python --build-arg HTTPS_PROXY=$(HTTP_PROXY) --build-arg HTTP_PROXY=$(HTTP_PROXY) --security-opt label=disable --target ansible-builder -t docker.io/ysebastia/ansible-builder:3.1.1

ansible-lint:
	podman build --no-cache src/python --build-arg HTTPS_PROXY=$(HTTP_PROXY) --build-arg HTTP_PROXY=$(HTTP_PROXY) --security-opt label=disable --target ansible-lint -t docker.io/ysebastia/ansible-lint:25.12.1

molecule:
	podman build --no-cache src/molecule --build-arg HTTPS_PROXY=$(HTTP_PROXY) --build-arg HTTP_PROXY=$(HTTP_PROXY) --security-opt label=disable -t docker.io/ysebastia/molecule

molecule_os:
	podman build --no-cache src/molecule-redhat --build-arg HTTPS_PROXY=$(HTTP_PROXY) --build-arg HTTP_PROXY=$(HTTP_PROXY) --security-opt label=disable --build-arg BASE_OS=registry.access.redhat.com/ubi9/ubi --build-arg VERSION_OS=9.6 -t docker.io/ysebastia/molecule:rhel-9.6
	podman build --no-cache src/molecule-redhat --build-arg HTTPS_PROXY=$(HTTP_PROXY) --build-arg HTTP_PROXY=$(HTTP_PROXY) --security-opt label=disable --build-arg BASE_OS=registry.access.redhat.com/ubi10/ubi --build-arg VERSION_OS=10.0 -t docker.io/ysebastia/molecule:rhel-10.0
	podman build --no-cache src/molecule-debian --build-arg HTTPS_PROXY=$(HTTP_PROXY) --build-arg HTTP_PROXY=$(HTTP_PROXY) --security-opt label=disable -t docker.io/ysebastia/molecule:debian-13.2

yamllint:
	podman build --no-cache src/python --build-arg HTTPS_PROXY=$(HTTP_PROXY) --build-arg HTTP_PROXY=$(HTTP_PROXY) --security-opt label=disable --target yamllint -t docker.io/ysebastia/yamllint:1.37.1

checkov:
	podman build --no-cache src/python --build-arg HTTPS_PROXY=$(HTTP_PROXY) --build-arg HTTP_PROXY=$(HTTP_PROXY) --security-opt label=disable --target checkov -t docker.io/ysebastia/checkov:3.2.495

pylint:
	podman build --no-cache src/python --build-arg HTTPS_PROXY=$(HTTP_PROXY) --build-arg HTTP_PROXY=$(HTTP_PROXY) --security-opt label=disable --target pylint -t docker.io/ysebastia/pylint:4.0.4

python: ansible ansible-builder ansible-lint checkov pylint yamllint
	

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
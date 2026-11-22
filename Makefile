all: python ansible ansible-builder molecule ansible-lint molecule_os other

ansible:
	podman build --no-cache src/python --build-arg HTTPS_PROXY=$(HTTP_PROXY) --build-arg HTTP_PROXY=$(HTTP_PROXY) --security-opt label=disable --target ansible -t docker.io/ysebastia/ansible:2.21.2

ansible-builder:
	podman build --no-cache src/python --build-arg HTTPS_PROXY=$(HTTP_PROXY) --build-arg HTTP_PROXY=$(HTTP_PROXY) --security-opt label=disable --target ansible-builder -t docker.io/ysebastia/ansible-builder:3.1.1

ansible-lint:
	podman build --no-cache src/python --build-arg HTTPS_PROXY=$(HTTP_PROXY) --build-arg HTTP_PROXY=$(HTTP_PROXY) --security-opt label=disable --target ansible-lint -t docker.io/ysebastia/ansible-lint:26.6.0

molecule:
	podman build --no-cache src/molecule --build-arg HTTPS_PROXY=$(HTTP_PROXY) --build-arg HTTP_PROXY=$(HTTP_PROXY) --security-opt label=disable -t docker.io/ysebastia/molecule:26.11.0

molecule_os:
	cd src/molecule-instance && $(MAKE) build

yamllint:
	podman build --no-cache src/python --build-arg HTTPS_PROXY=$(HTTP_PROXY) --build-arg HTTP_PROXY=$(HTTP_PROXY) --security-opt label=disable --target yamllint -t docker.io/ysebastia/yamllint:1.38.0

checkov:
	podman build --no-cache src/python --build-arg HTTPS_PROXY=$(HTTP_PROXY) --build-arg HTTP_PROXY=$(HTTP_PROXY) --security-opt label=disable --target checkov -t docker.io/ysebastia/checkov:3.2.495

pylint:
	podman build --no-cache src/python --build-arg HTTPS_PROXY=$(HTTP_PROXY) --build-arg HTTP_PROXY=$(HTTP_PROXY) --security-opt label=disable --target pylint -t docker.io/ysebastia/pylint:4.0.4

properdocs:
	podman build --no-cache src/python --build-arg HTTPS_PROXY=$(HTTP_PROXY) --build-arg HTTP_PROXY=$(HTTP_PROXY) --security-opt label=disable --target properdocs -t docker.io/ysebastia/properdocs:1.6.7

python: ansible ansible-builder ansible-lint checkov pylint yamllint properdocs
	

other: wget cloc helm shellcheck tflint hadolint

helm:
	podman build --no-cache src/helm -t docker.io/ysebastia/helm:3.19.1

shellcheck:
	podman build --no-cache src/shellcheck -t docker.io/ysebastia/shellcheck:0.11.0

tflint:
	podman build --no-cache src/tflint -t docker.io/ysebastia/tflint:0.66.0

cloc:
	podman build --no-cache src/cloc -t docker.io/ysebastia/cloc:2.08

wget:
	podman build --no-cache src/wget -t docker.io/ysebastia/wget:1.25.0-r3

hadolint:
	podman build --no-cache src/hadolint -t docker.io/ysebastia/hadolint:2.14.0
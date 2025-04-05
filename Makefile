ansible:
	docker build --progress=plain src/ansible -t ysebastia/ansible:2.18.4

molecule:
	docker build --progress=plain src/molecule -t ysebastia/molecule
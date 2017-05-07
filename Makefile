PARENT = $(shell basename ${CURDIR})

.PHONY: download tag-latest publish build

build:
	docker build . -t local_factorio
download:
	curl -L https://www.factorio.com/get-download/${VERSION}/headless/linux64 -o ./factorio_headless_x64.tar.xz
	sha1sum ./factorio_headless_x64.tar.xz
tag-latest:
	docker tag ${ID} arma26/factorio:latest
publish:
	docker push arma26/factorio:latest

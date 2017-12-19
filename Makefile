PARENT = $(shell basename ${CURDIR})

.PHONY: build
build:
	docker build . -t local_factorio

.PHONY: download
download:
	curl -L https://www.factorio.com/get-download/${VERSION}/headless/linux64 -o ./factorio_headless_x64.tar.xz
	sha1sum ./factorio_headless_x64.tar.xz

.PHONY: tag-latest
tag-latest:
	docker tag ${ID} arma26/factorio:latest

.PHONY: publish
publish:
	docker push arma26/factorio:latest

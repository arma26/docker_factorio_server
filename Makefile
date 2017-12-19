PARENT = $(shell basename ${CURDIR})

.PHONY: build
build:
	docker build . -t local_factorio \
	--build-arg FACTORIO_SHA1=${SHA} \
	--build-arg VERSION=${VERSION}

.PHONY: download
download:
	curl -L https://www.factorio.com/get-download/${VERSION}/headless/linux64 -o ./factorio_headless_x64.tar.xz
	sha1sum ./factorio_headless_x64.tar.xz

.PHONY: local-server
local-server:
	docker run -d --env FACTORIO_SERVER_NAME=factorio -v ${PWD}/saves:/opt/factorio/saves --env FACTORIO_VISIBILITY_PUBLIC=false -v ${PWD}/mods:/opt/factorio/mods -p 34197:34197/udp local_factorio:latest

.PHONY: tag-latest
tag-latest:
	docker tag ${ID} arma26/factorio:latest

.PHONY: tag-dev
tag-dev:
	docker tag ${ID} arma26/factorio:dev

.PHONY: publish
publish:
	docker push arma26/factorio:latest

.PHONY: publish-dev
publish-dev:
	docker push arma26/factorio:dev

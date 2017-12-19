PARENT = $(shell basename ${CURDIR})

.PHONY: build
build:
	docker build . -t local_factorio:${VERSION} \
	--build-arg FACTORIO_SHA1=${SHA} \
	--build-arg VERSION=${VERSION} \
	--build-arg FACTORIO_FILENAME=factorio_${VERSION}.tar.xz

.PHONY: download
download:
	curl -sL https://www.factorio.com/get-download/${VERSION}/headless/linux64 -o ./factorio_${VERSION}.tar.xz
	sha1sum ./factorio_${VERSION}.tar.xz

.PHONY: local-server
local-server:
	docker run -d --env FACTORIO_SERVER_NAME=factorio -v ${PWD}/saves:/opt/factorio/saves --env FACTORIO_VISIBILITY_PUBLIC=false -v ${PWD}/mods:/opt/factorio/mods -p 34197:34197/udp local_factorio:latest

.PHONY: tag
tag:
	docker tag ${ID} arma26/factorio:${VERSION}

.PHONY: publish
publish:
	docker push arma26/factorio:${VERSION}

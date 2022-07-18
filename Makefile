go_versions := 	1.17.0-alpine \
				1.18.0-alpine

py_versions := 3.11.0b4-alpine3.16

java_versions := 3-openjdk-18-slim

registery=ghcr.io
image_name=byteford/runner


src = 
version =
image = 

build-go:
	$(foreach version,$(go_versions),make docker-build src=go version=$(version) image=runner-go;)

build-python:
	$(foreach version,$(py_versions),make docker-build src=python version=$(version) image=runner-py;)

build-java:
	$(foreach version,$(java_versions),make docker-build src=java version=$(version) image=runner-java;)

build: 
	make build-go 
	make build-python 
	make build-java

docker-build:$(repo_url)/$(image):$(version)
	echo
	docker build ./$(src) --build-arg IMAGE_TAG=$(version) -t $(repo_url)/$(image):$(version)
	docker push $(registery)/$(image):$(version)
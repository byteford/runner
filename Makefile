go_versions := 	1.17.0 \
				1.18.0

py_versions := 3.11.0b4

java_versions := 18

registery=ghcr.io
image_name=byteford/runner


src = 
version =
image = 

build-go:
	$(foreach version,$(go_versions),make docker-build src=go version=$(version) image=runner-go;)

build-python:
	$(foreach version,$(py_versions),make docker-build src=python version=$(version) image=runner-python;)

build-java:
	$(foreach version,$(java_versions),make docker-build src=java version=$(version) image=runner-java;)

build: 
	make build-go 
	make build-python 
	make build-java

docker-build:
	docker build ./$(src) --build-arg IMAGE_TAG=$(version) -t $(registery)/$(image_name)/$(image):$(version)
	docker push $(registery)/$(image_name)/$(image):$(version)
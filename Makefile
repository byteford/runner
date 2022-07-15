go_versions := 	1.17.0 \
				1.18.0

py_versions := 3.11.0b4-alpine3.16

java_versions := 3-openjdk-18-slim

build-go:
	$(foreach version,$(go_versions),docker build ./go --build-arg $(version) -t runner-go:$(version)-alpine;)

build-python:
	$(foreach version,$(py_versions),docker build ./python --build-arg $(version) -t runner-py:$(version);)

build-java:
	$(foreach version,$(java_versions),docker build ./java --build-arg $(version) -t runner-java:$(version);)

build: build-go build-python build-java
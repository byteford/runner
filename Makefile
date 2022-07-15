go_versions := 	1.17.0 \
				1.18.0

py_versions := 3.11.0b4-alpine3.16

build:
	$(foreach version,$(go_versions),docker build ./go --build-arg $(version) -t runner-go:$(version)-alpine;)
	$(foreach version,$(py_versions),docker build ./python --build-arg $(version) -t runner-py:$(version);)
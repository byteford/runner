registery=ghcr.io
image_name=byteford/runner

src = 
version =
image = 
lang := go \
		java \
		python

build: 
	$(foreach language,$(lang),\
		$(foreach version,$(shell cat ./$(language)/versions),\
			make docker-build src=$(language) version=$(version) image=runner-$(language);))

docker-build:
	docker build ./$(src) --build-arg IMAGE_TAG=$(version) -t $(registery)/$(image_name)/$(image):$(version)
	docker push $(registery)/$(image_name)/$(image):$(version)
registery=ghcr.io
image_name=byteford/runner

src = 
version =
image = 
lang := go \
		maven \
		python \
		cs \
		js \
		terraform \
		ansible \
		k8s \
		ubuntu \
		crossplane

.PHONY:
	build

getVersions:
# will pull all versions of go - this might not be a good idea
	wget -q https://registry.hub.docker.com/v1/repositories/golang/tags -O -  | sed -e 's/[][]//g' -e 's/"//g' -e 's/ //g' | tr '}' '\n' | awk -F: '{print $$3}' | grep '[0-9][.][0-9][0-9][.][0-9]-alpine$$' | sed 's/-alpine//g' > ./go/versions.txt

build: 
	$(foreach language,$(lang),\
		$(foreach version,$(shell cat ./$(language)/versions.txt),\
			$(MAKE) docker-build src=$(language) version=$(version) image=runner-$(language);))

docker-build:
	docker build ./$(src) --build-arg IMAGE_TAG=$(version) -t $(registery)/$(image_name)/$(image):$(version)
	docker push $(registery)/$(image_name)/$(image):$(version)
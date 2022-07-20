
run:
	echo "Running"
	echo "Params: ${PARAMS}"
	echo "ENV: ${ENV}"
	cd ${WORKDIR} && go run . ${PARAMS}

test:
	echo "Running"
	echo "Params: ${PARAMS}"
	echo "ENV: ${ENV}"
	cd ${WORKDIR} && ${ENV} go test . -v ${PARAMS}

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

init:
	echo "Running"
	echo "Params: ${PARAMS}"
	echo "ENV: ${ENV}"
	cd ${WORKDIR} && ${ENV} go mod init ${PARAMS}

tidy:
	echo "Running"
	echo "Params: ${PARAMS}"
	echo "ENV: ${ENV}"
	cd ${WORKDIR} && ${ENV} go mod tidy ${PARAMS}
	
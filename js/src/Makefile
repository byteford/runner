run:
	echo "Running"
	echo ${PARAMS}
	cd ${WORKDIR} && npm install
	cd ${WORKDIR} && npm start ${PARAMS}

build:
	echo "Building"
	echo ${PARAMS}
	cd ${WORKDIR} && npm install
	cd ${WORKDIR} && npm run build ${PARAMS}

test:
	echo "Building"
	echo ${PARAMS}
	cd ${WORKDIR} && npm install
	cd ${WORKDIR} && npm run test ${PARAMS}

serve:
	echo "Serving"
	npm install -g serve
	serve -s ${WORKDIR}build
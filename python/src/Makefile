setup:
	echo "Setup"
	echo ${PARAMS}
	cd ${WORKDIR} && python -m pip install -r requirements.txt

run:
	echo "Running"
	echo ${PARAMS}
	cd ${WORKDIR} && python -m pip install -r requirements.txt
	cd ${WORKDIR} && python ${PARAMS}

lint: 
	echo "Lint"
	echo ${PARAMS}
	cd ${WORKDIR} && python -m pip install pylint
	cd ${WORKDIR} && python -m pylint ${PARAMS}

test:
	echo "Test"
	echo ${PARAMS}
	cd ${WORKDIR} && python -m pip install pytest
	cd ${WORKDIR} && python -m pytest ${PARAMS}
setup:
	echo "Setup"
	echo ${PARAMS}
	cd ${WORKDIR} && python -m pip install -r ${PARAMS}requirements.txt

run:
	echo "Running"
	echo ${PARAMS}
	cd ${WORKDIR} && python -m pip install -r requirements.txt
	cd ${WORKDIR} && python ${PARAMS}

lint: 
	echo "Lint"
	echo ${PARAMS}
	cd ${WORKDIR} && python -m pip install flake8
	cd ${WORKDIR} && python -m flake8 ${PARAMS}

test:
	echo "Test"
	echo ${PARAMS}
	cd ${WORKDIR} && python -m pip install pytest
	cd ${WORKDIR} && python -m pytest ${PARAMS}
setup:
	echo "Setup"
	echo ${PARAMS}
	cd ${WORKDIR} && python -m pip install -r ${PARAMS}requirements.txt

run:
	echo "Running"
	echo ${PARAMS}
	cd ${WORKDIR} && ansible-playbook -i inventory main.py ${PARAMS}
login:
	echo "login"
	echo ${PARAMS}
	cd ${WORKDIR} && terraform login ${PARAMS}
init:
	echo "init"
	echo ${PARAMS}
	cd ${WORKDIR} && terraform init ${PARAMS}
plan:
	echo "plan"
	echo ${PARAMS}
	cd ${WORKDIR} && terraform plan ${PARAMS}
apply:
	echo "Running"
	echo ${PARAMS}
	cd ${WORKDIR} && terraform apply ${PARAMS}
delete:
	echo "Running"
	echo ${PARAMS}
	cd ${WORKDIR} && terraform delete ${PARAMS}
fmt:
	echo "Running"
	echo ${PARAMS}
	cd ${WORKDIR} && terraform fmt ${PARAMS}

lint:
	echo "Running"
	echo ${PARAMS}
	tflint --chdir=${WORKDIR} --init
	tflint --chdir=${WORKDIR} ${PARAMS}
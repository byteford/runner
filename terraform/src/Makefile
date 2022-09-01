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

tflint:
	echo "Running"
	echo ${PARAMS}
	cd ${WORKDIR} && tflint --init
	cd ${WORKDIR} && tflint ${PARAMS}
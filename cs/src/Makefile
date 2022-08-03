
runserver:
	echo "Running"
	echo "Params: ${PARAMS}"
	echo "ENV: ${ENV}"
	cd ${WORKDIR} && dotnet dev-certs https
	cd ${WORKDIR} && dotnet run --urls=https://0.0.0.0:3000/
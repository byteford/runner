#!/bin/bash


################################################################################
# Help                                                                         #
################################################################################
Help()
{
   # Display Help
   echo "Add description of the script functions here."
   echo
   echo "Syntax: runner.sh start|stop|app|<command> [-v|-l]"
   echo "options:"
   echo "-l --language     The language the application is writen in"
   echo "-v --version      The version of the language to use"
   echo ""
   echo "Management Commands:"
   echo "start     Start the container"
   echo "stop      Stops the container"
   echo "app       runs commmands direct on the app"
   echo ""
   echo "Commands:"
   echo "run       runs the code within the container"
}

################################################################################
################################################################################
# Main program                                                                 #
################################################################################
################################################################################




WORKDIR="/src"
MAKEFILEDIR="/make"

repo_url="ghcr.io/byteford/runner"

#Go versions 
go1170="$repo_url/runner-go:1.17.0-alpine"
go1180="$repo_url/runner-go:1.18.0-alpine"

#python versions
python3110b4="$repo_url/runner-py:3.11.0b4-alpine3.16"

#Java versions
java318="$repo_url/runner-java:3-openjdk-18-slim"

image="alpine"

#fuction that will replace the / with an _ to make it docker name complient (this might need a limit on caracter legnth)
function get_name () {
    loc=$(pwd)
    echo "${loc//['\/']/}"
}

#function that will start a running container and will tell the user if it is already started (maybe fail silently)
function start_container(){
    echo $image
    #uses rm to delete the container once finished as the container shouldn't save anything in it
    docker run -it --detach --rm --name $(get_name) --volume $(pwd):$WORKDIR --env "WORKDIR=$WORKDIR" $image
    # if the error code is 125 then the container is already started
    err=$?
    if [ $err -ne 0 ]; then
        if [ $err -eq 125 ]; then 
            echo "already started"
            exit $err
        fi
        echo "failed to start"
        exit $err
    fi
    echo "successfully Started"
}

function stop_container(){
    docker stop $(get_name) 
    err=$?
    if [ $err -ne 0 ]; then
        echo "failed to stop"
        exit $err
    fi
    echo "successfully Stopped"
    
}

function run_app_command(){
    docker exec -it -w $WORKDIR $(get_name) $*
}

function run_make_command(){
    echo $*
    docker exec -it -w $MAKEFILEDIR $(get_name) make PARAMS=${@:2} $1
}

#if no errors print out a very basic run funtion
if [[ $# -eq 0 ]]; then
    Help
    exit 1
fi


POSITIONAL_ARGS=()

while [[ $# -gt 0 ]]; do
  case $1 in
    -v|--version)
      VERSION="$2"
      shift # past argument
      shift # past value
      ;;
    -l|--language)
      LANGUAGE="$2"
      shift # past argument
      shift # past value
      ;;
    *)
      POSITIONAL_ARGS+=("$1") # save positional arg
      shift # past argument
      ;;
  esac
done

set -- "${POSITIONAL_ARGS[@]}"


case $1 in 
"start")
    if [ -z ${LANGUAGE} ]; then echo "LANGUAGE is unset";exit 1; fi
    if [ -z ${VERSION} ]; then echo "VERSION is unset";exit 1; fi

    VERSION=${VERSION//['.']/}
    echo $LANGUAGE$VERSION
    image=$LANGUAGE$VERSION
    image=${!image}
    start_container
    shift
    ;;
"stop")
    stop_container
    shift
    ;;
"app")
    run_app_command "${@:2}"
    shift
    ;;
*)
    run_make_command $*
    shift
    ;;
esac

exit 0
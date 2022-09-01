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
   echo "-h --help         Displays this message"
   echo "Start time:"
   echo "-l --language     The language the application is writen in"
   echo "-v --version      The version of the language to use"
   echo "-p --publish      This creates a firewall rule which maps a container port to a port on the Docker host to the outside world."
   echo "-e --enviroment   Specify an environemnt variable to run the container with"
   echo "-w --workdir      Set if you want to copy in your local folder, but run commands on a sub-folder"

   echo "Run time:"
   echo "-e --enviroment   Specify an environemnt variable to run the code with"
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

image="alpine"

ENVVARS=()

#fuction that will replace the / with an _ to make it docker name complient (this might need a limit on caracter legnth)
function get_name () {
    loc=$(pwd)
    echo "${loc//['\/']/}"
}

#function that will start a running container and will tell the user if it is already started (maybe fail silently)
function start_container(){
    echo $image
    ENV="${ENVVARS[@]/#/--env }"
    echo $ENV
    #uses rm to delete the container once finished as the container shouldn't save anything in it
    docker run -it --detach --rm --name $(get_name) $PUBLISH --volume $(pwd):$WORKDIR --env "WORKDIR=$WORKDIR/$WORKDIRSUFFIX" $ENV $image
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

#function will stop a running container with the name of the current pwd
function stop_container(){
    docker stop $(get_name) 
    err=$?
    if [ $err -ne 0 ]; then
        echo "failed to stop"
        exit $err
    fi
    echo "successfully Stopped"
    
}

#will run a command on the ocntainer
function run_app_command(){
    docker exec -it -w $WORKDIR $(get_name) $*
}

#will run a make rule with in the given container
function run_make_command(){
    echo $*
    docker exec -it -w $MAKEFILEDIR $(get_name) make PARAMS=${@:2} ENV="${ENVVARS[*]}" $1
}
#Work out language based on file extention
function LangCalc(){
  for i in *.go; do
      [ -f "$i" ] || break
      LANGUAGE=go
      return
  done
  for i in *.py; do
      [ -f "$i" ] || break
      LANGUAGE=python
      return
  done
  for i in *.java; do
      [ -f "$i" ] || break
      LANGUAGE=maven
      return
  done
  for i in *.cs; do
      [ -f "$i" ] || break
      LANGUAGE=cs
      return
  done
  for i in *.tf; do
      [ -f "$i" ] || break
      LANGUAGE=terraform
      return
  done
  if [ -f "package.json" ]; then
      LANGUAGE=js
      return
  fi
  if [ -f "pom.xml" ]; then
    LANGUAGE=maven
    return
  fi
}

function VersionCalc(){
  case $LANGUAGE in
    go)
      VERSION="1.18.0"
      return
    ;;
    maven)
      VERSION="18"
      return
    ;;
    python)
      VERSION="3.11.0b4"
      return
    ;;
    cs)
      VERSION="6.0"
      return
    ;;
    js)
      VERSION="18"
      return
    ;;
    terraform)
      VERSION="1.2.7"
      return
    ;;
    *)
     echo "default version not found"
     exit 1
    ;;
  esac
}

#if no errors print out a very basic help funtion
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
    -e|--enviroment)
      ENVVARS+=("$2")
      echo "set $2"
      shift
      shift
      ;;
    -p|--publish)
      PUBLISH+="--publish $2"
      shift
      shift
      ;;
    -w|--workdir)
      WORKDIRSUFFIX+="$2"
      shift
      shift
      ;;
    -h| --help)
      Help
      exit 0
      ;;
    *)
      POSITIONAL_ARGS+=("$1") # save positional arg
      shift # past argument
      ;;
  esac
done

set -- "${POSITIONAL_ARGS[@]}"

echo "${ENVVARS[@]}"

case $1 in 
"start")
    if [ -z ${LANGUAGE} ]; then 
      LangCalc #gets the language by looks like the local files
    fi
    if [ -z ${VERSION} ]; then 
      VersionCalc #get a default version based on language
    fi

    image=$repo_url/runner-$LANGUAGE:$VERSION
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
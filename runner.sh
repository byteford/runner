#!/bin/bash

WORKDIR="/src"
MAKEFILEDIR="/make"
#fuction that will replace the / with an _ to make it docker name complient (this might need a limit on caracter legnth)
function get_name () {
    loc=$(pwd)
    echo "${loc//['\/']/}"
}

#function that will start a running container and will tell the user if it is already started (maybe fail silently)
function start_container(){
    #uses rm to delete the container once finished as the container shouldn't save anything in it
    docker run -it --detach --rm --name $(get_name) --volume $(pwd):$WORKDIR --env "WORKDIR=$WORKDIR" runner-go:1.17.0-alpine
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
    docker exec -it -w $MAKEFILEDIR $(get_name) make $*
}

#if no errors print out a very basic run funtion
if [[ $# -eq 0 ]]; then
    echo start       : starts the runner
    echo stop        : stopes the runner
    echo "app <command>  : run the command in the runner"
    exit 1
fi

case $1 in 
"start")
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
    run_make_command
    shift
    ;;
esac

exit 0
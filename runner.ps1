param(
    [Parameter(Position=0)][string[]]$command,
    [Parameter(ValueFromRemainingArguments)][string[]] $params,
    [Alias("l")][string]$language,
    [Alias("v")][string]$version,
    [Alias("p")][string[]]$publish,
    [Alias("e")][string[]]$enviroment
)

$WORKDIR="/src"
$MAKEFILEDIR="/make"

$repo_url="ghcr.io/byteford/runner"

$image="alpine"

function get_name{

    Write-Output (($pwd.Path -replace "\\","") -replace ":","")
}

function start_container{
    if ($publish -ne $null){
        $pre = "-p"
    }
    $env = "--env " + $enviroment -join "--env "
    echo $env
    docker run -it --detach --rm --name $(get_name) $pre "$publish" --volume ${pwd}:$WORKDIR --env WORKDIR=$WORKDIR $env $image
}

function stop_container{
    docker stop $(get_name)
}

switch($command){

    "start"{
        $image="$repo_url/runner-${language}:$version"
        start_container
    }
    "stop"{
        stop_container
    }
    "app"{
        docker exec -it -w $WORKDIR $(get_name) $params
    }
    default {
        docker exec -it -w $MAKEFILEDIR $(get_name) make PARAMS=$params $command
    }

}
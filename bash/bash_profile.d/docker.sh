alias  d='docker'
alias dc='docker-compose'
alias dm='docker-machine'

# some other handy aliases for things I tend to have running in docker
alias     pg-dev='psql -hdb -Upostgres'
alias    rmq-dev='open http://rmq:15672'
alias     es-dev='open http://elasticsearch:9200'
alias kibana-dev='open http://kibana:5601'

# unset environment variables to fall back to Docker for Mac
function dmc-unset {
  eval $(docker-machine env -u)
  export DOCKER_MACHINE_IP=127.0.0.1
}

# set environment variables for specified docker machine (defaults to "default")
function dmc-set {
  machine="${1:-default}"

  status=`docker-machine status $machine`
  if [ $status != "Running" ]; then
    echo "Docker machine $machine is not running: $status"
    return 1
  fi

  eval $(docker-machine env $machine)
  export DOCKER_MACHINE_IP=$(docker-machine ip)
}

# handy aliases for things I tend to have running in docker
alias     pg-dev='psql postgres://postgres:postgres@localhost:5432/postgres'
alias    rmq-dev='open http://localhost:15672'
alias     mx-dev='open http://localhost:1080'
alias     es-dev='open http://localhost:9200'
alias kibana-dev='open http://localhost:5601'

alias dc="docker-compose"
alias dcl="docker-compose logs -f --tail 0"

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

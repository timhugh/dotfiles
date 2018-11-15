# docker-compose
alias dc='docker-compose'

# docker-machine
alias dm='docker-machine'
function dmc {
  dmc-check-current && return
  docker-machine $@ $CURRENT_DOCKER_MACHINE
}
function dmc-env {
  dmc-check-current && return
  eval $(docker-machine env $CURRENT_DOCKER_MACHINE)
}
function dmc-check-current {
  [[ -z $CURRENT_DOCKER_MACHINE ]] && echo 'current docker machine is not set' && return 1
}
function dm-env {
  [[ -z $1 ]] && echo 'Must specify name of docker machine' && return 1
  export CURRENT_DOCKER_MACHINE=$1
  dmc-env
}

# init docker env for default machine
[[ -n $CURRENT_DOCKER_MACHINE ]] && [[ "$(docker-machine status $CURRENT_DOCKER_MACHINE)" == *"Running"* ]] && dmc-env

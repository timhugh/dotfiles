# docker-compose shortcut
alias dc='docker-compose'

# docker-machine shortcut
alias dm='docker-machine'

# Utilities for managing multiple docker-machines.
#
# NOTE: This is all much easier with the use of docker-machine-ipconfig:
#       https://github.com/fivestars/docker-machine-ipconfig
#
#       It allows you to assign static IPs to each docker-machine VM so you
#       don't have to worry about boot order messing up your hosts file or
#       requiring you to renegerate certificates

DMC_FILE=~/.current-docker-machine

# dmc-env
# Sets docker environment variables in the current sessions for the
# preferred/current machine.
function dmc-env {
  machine=$(_dmc-get-current)
  if [ -z "$machine" ]; then
    echo "Preferred machine is not set (use dmc-set)"
    return 1
  fi
  status=`docker-machine status`
  if [ $status != "Running" ]; then
    echo "Docker machine is not running: $status"
    return 1
  fi

  eval $(docker-machine env $machine)
}

# dmc-set
# Sets preferred/current machine, which will be used for all sessions until
# dmc-set is called again for a different machine).
function dmc-set {
  machine="$1"
  if [ -z "$machine" ]; then
    echo 'Must specify a machine: `dmc-set mymachine`'
    return 1
  fi
  export CURRENT_DOCKER_MACHINE="$machine"
  _dmc-write "$machine"
  dmc-env
}

function _dmc-get-current {
  if [ -n "$CURRENT_DOCKER_MACHINE" ]; then
    echo "$CURRENT_DOCKER_MACHINE"
  else
    if [ -f "$DMC_FILE" ]; then
      echo $(cat "$DMC_FILE")
    fi
  fi
}

function _dmc-write {
  machine="$1"
  if [ -n "$machine" ]; then
    echo "$machine" > $DMC_FILE
  fi
}

# Call dmc-env when session starts, if there's a current/preferred machine.
machine=$(_dmc-get-current)
[[ -n $machine ]] && dmc-env

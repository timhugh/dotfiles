if command -v kubectl &> /dev/null
then
  # source <(kubectl completion zsh)

  alias kc='kubectl'
  alias kt='kubetail'

  alias kp='kubectl get pod'
  alias kd='kubectl get deployment'
  alias ks='kubectl get svc'
  alias ki='kubectl get ingress'
fi

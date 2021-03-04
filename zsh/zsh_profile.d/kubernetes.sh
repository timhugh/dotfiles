if [ -x "$(command -v kubectl)" ]; then
  alias  k='kubectl'
  alias kt='kubetail'
  alias  h='helm'

  alias kp='kubectl get pod'
  alias kd='kubectl get deployment'
  alias ks='kubectl get svc'
  alias ki='kubectl get ingress'
fi

function merge_config() {
  export KUBECONFIG=$XDG_CONFIG_HOME/kube/config:$(find . -type f | tr '\n' ':')
  kubectl config view --flatten > $XDG_CONFIG_HOME/kube/config
}

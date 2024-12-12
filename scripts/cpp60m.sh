#!/bin/bash

# Definindo a função
echo "Verificando pods pending nos ultimos 60 minutos"
check_pending_pods() {
  kubectl get pods --all-namespaces -o json | \
  jq -r '.items[] | select(.status.phase=="Pending") | "\(.metadata.creationTimestamp) \(.metadata.namespace)/\(.metadata.name)"' | \
  while read date pod; do
    if [[ "$(date -d"$date" +%s)" -gt "$(date -d"1 hour ago" +%s)" ]]; then
      echo $pod
    fi
  done
}


# Chamando as funções
check_pending_pods
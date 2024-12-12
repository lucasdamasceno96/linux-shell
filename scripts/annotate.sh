#!/bin/env bash

# Lista de nós
nodes=(

)

# Função para drenar e deletar um nó
process_node() {
  # oc get machine $node -n openshift-machine-api
  # oc adm drain $node --ignore-daemonsets --force --delete-local-data
  oc annotate machine/$node -n openshift-machine-api machine.openshift.io/cluster-api-delete-machine="true"
}


for node in "${nodes[@]}"; do
  process_node $node &
done

# Esperar todos os processos terminarem
wait
echo "Todos as maquinas foram "anotadas""
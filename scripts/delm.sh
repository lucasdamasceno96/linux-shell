#!/bin/bash

# Lista de nós
nodes=(

)

# Função para drenar e deletar um nó
process_node() {
  echo "Deletando a maquina $node..."
  oc get machine $node -n openshift-machine-api
  oc delete machine $node --force -n openshift-machine-api
}

# Processar cada nó com diferença de 5 minutos
for node in "${nodes[@]}"; do
  process_node $node &
  echo "Esperando 2 minutos antes de deletar a proxima maquina ..."
  sleep 120
done

# Esperar todos os processos terminarem
wait
echo "Todos os nós foram processados."

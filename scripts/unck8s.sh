#!/bin/bash

# Obter a lista de todos os nodes que estão em SchedulingDisabled
nodes=$(kubectl get nodes --no-headers | grep 'SchedulingDisabled' | awk '{print $1}')

# Iterar sobre cada node e verificar o status de "Ready"
for node in $nodes; do
    status=$(kubectl get node $node -o jsonpath='{.status.conditions[?(@.type=="Ready")].status}')
    if [ "$status" == "True" ]; then
        echo "Executando kubectl uncordon no node: $node"
        kubectl uncordon $node
    fi
done

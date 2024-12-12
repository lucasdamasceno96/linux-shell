#!/bin/env bash
nodes=(

)
# Loop através do array de máquinas
for node in "${nodes[@]}"
do
  kubectl get node $node
  kubectl drain $node --ignore-daemonsets --force --delete-emptydir-data
  kubectl uncordon $node 
  sleep 1
done
echo "Todos nodes foram drenados"

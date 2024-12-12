#!/bin/bash

# Lista de nodes
NODES=(
)

# Taints a serem aplicadas
TAINTS=(
    "standby/reason=NoExecute:NoExecute"
    "node.kubernetes.io/unschedulable=NoSchedule:NoSchedule"
    "UpdateInProgress=PreferNoSchedule:PreferNoSchedule"
)

# Aplicando taints a cada node
for NODE in "${NODES[@]}"; do
    for TAINT in "${TAINTS[@]}"; do
        oc adm taint nodes $NODE $TAINT
        oc label nodes $NODE node-role.kubernetes.io/standby=true
        oc label nodes $NODE node-role.kubernetes.io/infra=true
    done
    echo "Taints aplicadas ao node $NODE"
done

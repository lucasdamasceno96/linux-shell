#!/bin/bash



for vmName in $(oc get nodes | grep 'SchedulingDisabled' | awk '{print $1}'
) ; do
    echo "Retirando cordon: $vmName"
    kubectl uncordon $vmName
done

echo "Todos nodes foram retirados de cordon"

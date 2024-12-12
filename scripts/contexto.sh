#!/bin/bash

# Função para perguntar ao usuário o namespace
get_input() {
  read -p "Digite o nome do namespace: " namespace
}

# Chama a função para obter o namespace
get_input

# Lista de clusters
nodes=(
  "k8sdesbb111"
  "k8shmlbb111"
  "k8sprdbb111"
)

# Loop para configurar o contexto do kubectl para cada cluster
for cluster in "${nodes[@]}"; do
  echo "Configurando contexto para o cluster: $cluster"
  
  # Configurar contexto do kubectl
  kubectl config use-context $cluster
  kubectl config set-context --current --namespace=$namespace
  
  # Espera 3 segundos antes de continuar para o próximo cluster
  sleep 3
done

echo "Contexto configurado para todos os clusters."

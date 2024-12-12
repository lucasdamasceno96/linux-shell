#!/bin/bash

# Função para perguntar ao usuário o nome do node
get_input() {
  read -p "Digite o nome do node: " node
}

# Chama a função para obter o nome do node
get_input

# Lista de clusters
nodes=(
  "k8s-servicos"
  "k8s-canais-prd"
  "k8s-apps-prd"
  "k8s-data-prd"
  "k8s-devops"
  "k8s-devops-infra"
  "k8s-automacao"
  "k8s-spi-prd"
)

# Loop para configurar o contexto do kubectl para cada cluster
for cluster in "${nodes[@]}"; do
  echo "Configurando contexto para o cluster: $cluster"
  # Configurar contexto do kubectl
  kubectl config use-context $cluster
  # Verificar se o node está presente no cluster
  kubectl get nodes | grep $node > /dev/null
  if [ $? -eq 0 ]; then
    echo "Node $node encontrado no cluster $cluster"
    break
  else
    echo "Node $node não encontrado no cluster $cluster"
  fi
  # Espera 3 segundos antes de continuar para o próximo cluster
  sleep 1
done

echo "Fim da lista de clusters"

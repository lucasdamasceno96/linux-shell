#!/bin/bash

# Função para perguntar ao usuário o namespace e cluster
get_input() {
  read -p "Digite o nome do namespace: " namespace
  read -p "Digite o nome do cluster de origem: " cluster_origem
  read -p "Digite o nome do cluster de destino: " cluster_destino
}

# Função para obter e salvar secrets
get_secrets() {
  local cluster=$1
  local namespace=$2
  local output_file=$3

  # Configurar contexto do kubectl
  kubectl config use-context $cluster
  kubectl config set-context --current --namespace=$namespace

  # Pegar secrets e salvar em um arquivo
  for _secret in $(kubectl get secrets -o jsonpath='{.items[*].metadata.name}' | tr ' ' '\n' | egrep -v '(default-token*|default-docker*|builder-*|deployer-docker|deployer-token*)'); do
    kubectl get secrets ${_secret} -o yaml >> $output_file
    echo "---" >> $output_file
  done
}

# Função para aplicar secrets no cluster de destino
apply_secrets() {
  local cluster=$1
  local namespace=$2
  local input_file=$3

  # Configurar contexto do kubectl
  kubectl config use-context $cluster
  kubectl config set-context --current --namespace=$namespace

  # Aplicar secrets
  kubectl apply -f $input_file
}

# Pedir entrada do usuário
get_input

# Nomes dos arquivos temporários
source_file="secrets-$cluster_origem-$namespace.yaml"
target_file="secrets-$cluster_destino-$namespace.yaml"

# Limpar arquivos anteriores
> $source_file
> $target_file

# Obter secrets do cluster de origem
get_secrets $cluster_origem $namespace $source_file

# Editar secrets, removendo metadados não essenciais
yq e 'del(.metadata.annotations, .metadata.creationTimestamp, .metadata.labels, .metadata.managedFields, .metadata.resourceVersion, .metadata.uid)' "$source_file" > "$target_file"
#yq e 'del(.metadata.creationTimestamp, .metadata.managedFields, .metadata.resourceVersion, .metadata.uid)' "$source_file" > "$target_file"

# kubectl apply -f secrets-$cluster_origem.yaml -n namespace --context k8sdesbb111
# Aplicar secrets no cluster de destino
#apply_secrets $cluster_destino $namespace $target_file

# Limpar arquivos temporários
#rm $source_file $target_file

#echo "Secrets copiados e aplicados com sucesso do cluster $cluster_origem para o cluster $cluster_destino no namespace $namespace."
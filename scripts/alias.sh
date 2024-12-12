## Alias

alias kc='kube-capacity'
alias kdeldni='kubectl delete dnsingress'
alias ocdeldni='oc delete dnsingress'
alias dni='dnsingress'
alias kdni='kubectl get dnsingress'
alias ocdni='oc delete dnsingress'
alias ocgdni='oc get dnsingress'
alias ocg='oc get'
alias ocgp='oc get pod'
alias ocdel='oc delete'
alias ocdelp='oc delete pod'
alias ocgn='oc get node'
alias ocgm='oc get machine -n openshift-machine-api'
alias dni='dnsingress'
alias ocdrain='oc adm drain --ignore-daemonsets --force --delete-local-data'
alias kdrain='kubectl drain --ignore-daemonsets --force --delete-local-data'
alias ocgnw='oc get nodes -l node.k8s.bb/servico=psc-workload-apps-worker'
alias ocgmw='oc get machines -l node.k8s.bb/servico=psc-workload-apps-worker -n openshift-machine-api'
alias kcgnw='kube-capacity --node-labels  node.k8s.bb/servico=psc-workload-apps-worker'
alias ku='kubectl uncordon'
alias ocgsh="oc get nodes | grep 'SchedulingDisabled' | awk '{print \$1}'"
alias ocgnot="oc get nodes | grep 'NotReady' | awk '{print \$1}'"
# functions
ocgs() { oc get secrets $1 -o jsonpath='{.data.tls\.crt}' | base64 -d | openssl x509 -noout -text; }
kgs() { kubectl get secrets $1 -o jsonpath='{.data.tls\.crt}' | base64 -d | openssl x509 -noout -text; }
export EDITOR=vim
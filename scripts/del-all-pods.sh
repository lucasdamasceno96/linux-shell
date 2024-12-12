
# Para deletar pods em todos os namespaces
oc get pods -A $(oc get pods -A --field-selector=status.phase!=Running -o jsonpath='{.items[*].metadata.name}')

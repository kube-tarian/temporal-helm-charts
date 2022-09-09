## K8ssandra Operator 
### Prerequisites
- Helm 3.x
- Kube Prometheus Stack 
```bash
helm upgrade --install promtheus prometheus-community/kube-prometheus-stack -n observability --create-namespace
```
### Intallation
#### Add Helm repo
```bash
helm repo add k8ssandra https://helm.k8ssandra.io/stable
helm repo update
```
#### custom values
```yaml
cassandra:
  version: "3.11.10"
  cassandraLibDirVolume:
    ## Update the storage class name based on the provider
    stroageClass: "civo-volume"
    size: 5Gi
  allowMultipleNodesPerWorker: true
  heap:
   size: 1G
   newGenSize: 1G
  resources:
    requests:
      cpu: 1000m
      memory: 2Gi
    limits:
      cpu: 1000m
      memory: 2Gi
  datacenters:
  - name: temporal
    size: 3
    racks:
    - name: default
kube-prometheus-stack:
  enabled: false
  prometheusOperator:
    enabled: false
stargate:
  enabled: true
```

#### Install the operator
```sh
helm upgrade --install -f values.yaml k8ssandra k8ssandra/k8ssandra -n temporal
```

#### Test installation
After all pods are running in k8ssandra namespace, run the test.sh script to get basic informaion

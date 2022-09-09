##  Temporal
### Prerequisites
- k8ssandra

#### pre-installation setup
Get username and passowrd for cassandra installed in temporal namespace and the values in values/values.cassandra.yaml
```sh
export CASSANDRA_USER=$(kubectl get -n temporal secret k8ssandra-superuser -o jsonpath="{.data.username}" | base64 --decode)
export CASSANDRA_PASSWORD=$(kubectl get secret -n temporal k8ssandra-superuser -o jsonpath="{.data.password}" | base64 --decode)
```
### Intallation
cd into helm-charts directory and run the following command
```sh
helm install -f values.yaml -f values/values.cassandra.yaml -n temporal temporal .
```

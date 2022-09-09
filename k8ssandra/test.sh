#!/usr/bin/env bash
NAMESPACE=temporal
export CASSANDRA_USER=$(kubectl get -n temporal secret k8ssandra-superuser -o jsonpath="{.data.username}" | base64 -D)
export CASSANDRA_PASSWORD=$(kubectl get secret -n temporal k8ssandra-superuser -o jsonpath="{.data.password}" | base64 --decode)
kubectl exec -it -n $NAMESPACE k8ssandra-temporal-default-sts-0   -c cassandra -- nodetool -u $CASSANDRA_USER -pw $CASSANDRA_PASSWORD status
kubectl exec -it -n $NAMESPACE k8ssandra-temporal-default-sts-0   -c cassandra -- nodetool -u $CASSANDRA_USER -pw $CASSANDRA_PASSWORD ring
kubectl exec -it -n $NAMESPACE k8ssandra-temporal-default-sts-0   -c cassandra -- nodetool -u $CASSANDRA_USER -pw $CASSANDRA_PASSWORD info

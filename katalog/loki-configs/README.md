# Logging operator configs for Loki

This package is a collection of logging operator Flow/ClusterFlow and Output/ClusterOutput configs to be used together with **Loki**.

## Requirements

- Kustomize >= `5.6.0`
- [logging-operated](../logging-operated)
- [logging-operator](../logging-operator)

## Configuration

> [WARNING!]
> This package cannot be used together with `configs` package, one excludes the other.

Configurations available (patched from the base [configs](../configs) ) :

- [loki-configs](loki-configs): all the configurations.
- [loki-configs/kubernetes](loki-configs/kubernetes): only the cluster wide pods logging configuration (infrastructural namespaced excluded).
- [loki-configs/infra](loki-configs/infra): only the infrastructural namespaces logs
- [loki-configs/ingress-nginx](loki-configs/ingress-nginx): only the nginx-ingress-controller logging configuration.
- [loki-configs/audit](loki-configs/audit): all the Kubernetes audit logs related configurations (with master selector and tolerations).
- [loki-configs/events](loki-configs/events): all the Kubernetes events related configurations (with master selector and tolerations).
- [loki-configs/systemd](loki-configs/systemd): all the systemd related configurations.
- [loki-configs/systemd/kubelet](loki-configs/systemd/common): kubelet, docker, ssh systemd service logs configuration.
- [loki-configs/systemd/etcd](loki-configs/systemd/etcd): only the etcd service logs configuration (with master selector and tolerations).

## Deployment

You can deploy all the configurations by running the following command in the root of the project:

```shell
kustomize build | kubectl apply -f -
```

You can also deploy only a configuration subset by running some of the following commands (for example):

```shell
kustomize build kubernetes | kubectl apply -f -
kustomize build infra | kubectl apply -f -
kustomize build ingress-nginx | kubectl apply -f -
kustomize build audit | kubectl apply -f -
kustomize build events | kubectl apply -f -
kustomize build systemd | kubectl apply -f -
kustomize build systemd/common | kubectl apply -f -
kustomize build systemd/etcd | kubectl apply -f -
```

## License

For license details please see [LICENSE](../../LICENSE)

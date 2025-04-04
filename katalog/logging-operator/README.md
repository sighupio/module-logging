# Logging Operator

<!-- <SD-DOCS> -->

Logging operator for Kubernetes based on Fluentd and Fluent-bit.

The Logging operator automates the deployment and configuration of a Kubernetes logging pipeline. The operator deploys
and configures a Fluent-bit DaemonSet on every node to collect container and application logs from the node file system
and a Fluentd StatefulSet that receive logs from Fluent-bit and send them to various outputs.

## Requirements

- Kubernetes >= `1.24.0`
- Kustomize >= `v3.5.3`

## Image repository and tag

- Logging operator: `ghcr.io/kube-logging/logging-operator:4.10.0`
- Logging operator repo: [Logging operator on GitHub][logging-operator-github]

## Configuration

In SIGHUP Distribution, Logging operator is deployed with the following default configuration:

- Replica number: `1`
- Resource limits are `100m` for CPU and `500Mi` for memory

## Deployment

You can deploy Logging operator by running the following command in the root of the project:

```shell
kustomize build | kubectl apply -f - --server-side
```

See [logging-operated](../logging-operated) for the fluentd and fluentbit stack deployment, [configs](../configs)
for OpenSearch Flow/Clusterflow and Output/ClusterOutput configuration and [loki-configs](../loki-configs) for Loki Flow/Clusterflow and Output/ClusterOutput configuration.

<!-- Links -->

[logging-operator-github]: https://github.com/banzaicloud/logging-operator

<!-- </SD-DOCS> -->

## License

For license details please see [LICENSE](../../LICENSE)

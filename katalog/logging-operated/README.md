# Logging Operated

<!-- <SD-DOCS> -->

The Logging operated package deploys the Fluentd and Fluent-bit stack via Logging operator CRDs.
It also deploys a MinIO instance for storing all the logs rejected from the configured outputs.

## Requirements

- Kubernetes >= `1.22.0`
- Kustomize >= `v5.6.0`
- [logging-operator][logging-operator]
- [prometheus-operator][prometheus-operator]
- [minio-ha](../minio-ha)

## Image repository and tag

- Fluentd: `ghcr.io/kube-logging/logging-operator/fluentd:6.0.3-full`
- Fluent Bit: `ghcr.io/fluent/fluent-bit:4.0.3`
- Config Reloader: `ghcr.io/kube-logging/logging-operator/config-reloader:6.0.3`

## Configuration

See the file [fluentd-fluentbit.yaml](fluentd-fluentbit.yml) in the root of the project for the stack configuration.

## Deployment

You can deploy Logging operated by running the following command in the root of the project:

```shell
kustomize build | kubectl apply -f - --server-side
```

## Error logs

All logs with errors in being sent to their outputs are collected by two MinIO instances.
These instances serve for debugging purposes and to understand why the collected logs are not being sent.
These MinIO instances are configured to have a 7-day file retention.

<!-- Links -->

[logging-operator]: https://github.com/sighup-io/fury-kubernetes-logging/blob/master/katalog/logging-operator
[prometheus-operator]: https://github.com/sighup-io/fury-kubernetes-monitoring/blob/master/katalog/prometheus-operator

<!-- </SD-DOCS> -->

## License

For license details please see [LICENSE](../../LICENSE)

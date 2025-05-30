# Loki Distributed

<!-- <SD-DOCS> -->

Loki is a horizontally scalable, highly available, multi-tenant log aggregation system inspired by Prometheus.
It is designed to be very cost effective and easy to operate.
It does not index the contents of the logs, but rather a set of labels for each log stream.

> [!NOTE]
> This package is named Loki Distributed because it was created using the upstream chart with the same name.
> From version 5.0.0 of the logging module the package has been migrated to use the `Loki` chart instead as
> upstream.

## Requirements

- Kubernetes >= `1.24.0`
- Kustomize >= `v3.10.0`
- [prometheus-operator from SD monitoring module][prometheus-operator]
- [grafana from SD monitoring module][grafana] (module version `>=1.15.0`)
- [minio-ha](../minio-ha)

> Prometheus Operator is necessary since we configure a `ServiceMonitor` to make
> some metrics available from `loki` on prometheus

## Image repository and tag

- Loki image: `grafana/loki`
- Loki repo: [Loki on Github][loki-gh]

## Configuration

Loki Distributed is deployed in the following configuration:

- Each microservice has its own Deployment/StatefulSet
- Each Deployment has its own HPA
- Common resources set as:

```yaml
resources:
  requests:
    cpu: 100m
    memory: 128Mi
  limits:
    cpu: 500m
    memory: 1024Mi
```

## Deployment

You can deploy Loki Distributed by running the following command in the root of
the project:

```shell
kustomize build | kubectl apply -f -
```

This project also implements a dynamic Loki datasource that our Grafana from the monitoring stack automatically fetches and configures.
To see the logs, navigate in Grafana to the [explore section][grafana-explore-doc].

> Note: These instructions are only for installing Loki as a log storage solution.
> For complete instructions, please refer to the main README of the Logging module.

<!-- Links -->

[prometheus-operator]: https://github.com/sighup-io/fury-kubernetes-monitoring/blob/master/katalog/prometheus-operator
[grafana]: https://github.com/sighup-io/fury-kubernetes-monitoring/blob/master/katalog/grafana
[grafana-explore-doc]: https://grafana.com/docs/grafana/latest/explore/
[loki-gh]: https://github.com/grafana/loki

<!-- </SD-DOCS> -->

## License

For license details please see [LICENSE](../../LICENSE)

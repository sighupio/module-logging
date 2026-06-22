# OpenSearch - maintenance


The upgrade is handled automatically by `upgrade.sh`. First, find the latest chart version:

```bash
helm repo add opensearch https://opensearch-project.github.io/helm-charts
helm repo update
helm search repo opensearch/opensearch
```

Then run:

```bash
OPENSEARCH_CHART_VERSION=3.7.0 ./upgrade.sh
```

The provided values will deploy a custom `fsgroups` initContainer, because the one provided with vanilla values
does not change the `fs.file-max` value with `sysctl`.
We also added a custom sidecar container to export Prometheus metrics. We are using this strategy because the [prometheus-exporter](https://github.com/Aiven-Open/prometheus-exporter-plugin-for-opensearch) plugin is not compatible with the latest versions of OpenSearch yet.

Then, Kustomize will automate the following changes:

- custom prometheus AlertRules
- security plugin disabled via ConfigMap
- image tag pinning for `alpine`, `elasticsearch-exporter`, and `opensearch-dashboards`

## Prometheus metrics

The upstream chart exposes a `metrics` port (`9600`) for OpenSearch's performance analyzer.
We disable the performance analyzer and use an `elasticsearch-exporter` sidecar instead.

`upgrade.sh` adds a `prom-metrics` port (`9108`) to both services so the ServiceMonitor (`sm.yml`) scrapes the exporter sidecar.

[opensearch-helm-charts]: https://github.com/opensearch-project/helm-charts/releases

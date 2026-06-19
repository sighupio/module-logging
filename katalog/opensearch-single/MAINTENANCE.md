# OpenSearch - maintenance


The upgrade is handled automatically by the `upgrade` task. First, find the available chart versions:

```bash
mise run chart-versions
```

Then run:

```bash
mise run upgrade 3.7.0
```

**NOTE:** the chart version here MUST be kept in sync with [`opensearch-dashboards`](../opensearch-dashboards/MAINTENANCE.md).

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

The `upgrade` task adds a `prom-metrics` port (`9108`) to both services so the ServiceMonitor (`sm.yml`) scrapes the exporter sidecar.

[opensearch-helm-charts]: https://github.com/opensearch-project/helm-charts/releases

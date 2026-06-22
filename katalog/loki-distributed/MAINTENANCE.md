# Loki Distributed - maintenance

> [!NOTE]
> This package is named Loki Distributed because it was created using the upstream chart with the same name.
> From version 5.0.0 of the logging module the package has been migrated to use the `Loki` chart instead as
> upstream.

The upgrade is handled automatically by `upgrade.sh`. First, find the latest chart version:

```bash
helm repo add grafana-community https://grafana-community.github.io/helm-charts
helm repo update
helm search repo grafana-community/loki -o json | jq -r '.[0].version'
```

Then run:

```bash
LOKI_CHART_VERSION=17.4.4 ./upgrade.sh
```

The script performs the following operations on top of the chart output:

- Extracts the Loki config and gateway config from the chart-generated resources to `configs/`
- Removes the chart-generated Secret and ConfigMap from `deploy.yaml` (recreated by kustomize generators)
- Renames the gateway Service from `loki-distributed-gateway` to `loki-stack` for backward compatibility
- Downloads and customizes Loki mixins (dashboards and rules) matching the chart version

The following are handled by helm values in `MAINTENANCE.values.yaml` (no manual patching needed):

- `configStorageType: Secret` — Loki config is stored as a Secret instead of a ConfigMap
- `migrate.fromDistributed.enabled` — preserves memberlist compatibility during upgrade
- `extraEnvFrom` — injects minio credentials Secret
- `memcached.enabled: false` — disables unused memcached ServiceAccount
- `monitoring.serviceMonitor.enabled: true` — chart generates the ServiceMonitor natively

All components follow the `loki-distributed` naming to maintain compatibility with existing resources.

## Loki mixins

The official [Loki mixins](https://github.com/grafana/loki/tree/main/production/loki-mixin-compiled) dashboard
and rules are downloaded and customized automatically by `upgrade.sh`, matching the Loki version of the chart.

[github-releases]: https://github.com/grafana/helm-charts/releases?q=helm-loki&expanded=true

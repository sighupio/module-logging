# Loki Distributed - maintenance

To maintain the Loki package, you should follow these steps.

Search the latest `loki-distributed` and `loki` chart from [Grafana Helm Charts releases][github-releases] (there are other charts in the releases page).

Then you can template the charts using the following commands

```bash
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
helm template loki-distributed grafana/loki-distributed --values MAINTENANCE.values.yaml -n logging > loki-distributed-built.yaml
helm template loki grafana/loki --values MAINTENANCE.values.newchart.yaml -n logging > loki-built.yaml
```

With the `loki-distributed-built.yaml` file and `loki-built.yaml` file, check differences with the current `deploy.yml` file and change accordingly.

What was customized (what differs from the helm template command):

- Loki configuration has been moved on it's own file `configs/config.yaml`
- Gateway service has been renamed from `loki-distributed-gateway` to `loki-stack` to maintain compatibility with existing loki-configs
- Configmap loki-distributed has been changed to a secret
- The `loki-distributed-built.yaml` has been changed with new and updated components from the `loki-built.yaml`. The combination of the two forms the
  `deploy.yaml` file. The following changes have been made.
- The config.yaml file has been changed removing the deprecated values that are no more compatible with the version 3.x of Loki
- Two new components (that are not present in the `loki-distributed` chart) have been added: the `query-scheduler` and the `index-gateway`, along with
  their services and ServiceMonitor.
- The ServiceMonitors are not supported anymore with the new chart (they can still be used, when created manually, but will not be created automatically
  when using the new chart).
- The new components follow the `loki-distributed` naming.
- The path where to mount the `loki-runtime` configuration has been changed with the 3.x version.
- The nginx configuration used is the one from `loki-built.yaml`, since the `loki-distributed-built.yaml` one is old.

[github-releases]: https://github.com/grafana/helm-charts/releases?q=loki-distributed&expanded=true

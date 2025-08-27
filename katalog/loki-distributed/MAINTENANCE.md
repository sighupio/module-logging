# Loki Distributed - maintenance

> [!NOTE]
> This package is named Loki Distributed because it was created using the upstream chart with the same name.
> From version 5.0.0 of the logging module the package has been migrated to use the `Loki` chart instead as
> upstream.

To maintain the Loki package, you should follow these steps.

Search the latest `Helm Loki` (and not `loki-distributed`) chart from [Grafana Helm Charts releases][github-releases] (there are other charts in the releases page).

Then you can template the chart using the following commands (change the chart version accordingly in the last command):

```bash
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
helm template loki-distributed grafana/loki --version 6.37.0 --values MAINTENANCE.values.yaml -n logging > loki-built.yaml
```

With the `loki-built.yaml` file, check differences with the current `deploy.yml` file and change accordingly.

The following has been modified manually on top of what's generated from the chart:

- Loki configuration has been moved on it's own file `configs/config.yaml`
- Gateway service has been renamed from `loki-distributed-gateway` to `loki-stack` to maintain compatibility with existing loki-configs
- Configmap loki has been changed to a secret
- The ServiceMonitors are not supported anymore with the new chart (they can still be used, when created manually, but will not be created automatically
  when using the new chart). Hence they have been moved into the service-monitor.yaml file.
- The components follow the `loki-distributed` naming to maintain compatibility with existing resources.
- The `loki-memberlist` Service has been renamed to `loki-distributed-memberlist` to maintain compatibility.

[github-releases]: https://github.com/grafana/helm-charts/releases?q=loki-distributed&expanded=true

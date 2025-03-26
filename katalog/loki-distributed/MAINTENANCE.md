# Loki Distributed - maintenance

To maintain the Loki package, you should follow these steps.

Search the latest `loki` chart from [Grafana Helm Charts releases][github-releases] (there are other charts in the releases page).

Then you can template the chart using the following commands

```bash
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
helm template loki grafana/loki --values MAINTENANCE.values.yaml -n logging > loki-built.yaml
```

With the `loki-built.yaml` file, check differences with the current `deploy.yml` file and change accordingly.

What was customized (what differs from the helm template command):

- Loki configuration has been moved on it's own file `configs/config.yaml`
- Gateway service has been renamed from `loki-distributed-gateway` to `loki-stack` to maintain compatibility with existing loki-configs
- Configmap loki has been changed to a secret
- The ServiceMonitors are not supported anymore with the new chart (they can still be used, when created manually, but will not be created automatically
  when using the new chart). Hence they have been moved into the service-monitor.yaml file.
- The components follow the `loki-distributed` naming to maintain compatibility with existing resources.
- The `loki-memberlist` Service has been renamed to `loki-distributed-memberlist` to maintain compatibility.

[github-releases]: https://github.com/grafana/helm-charts/releases?q=loki-distributed&expanded=true

# Opensearch Dashboards - maintenance

The upgrade is handled automatically by `upgrade.sh`. First, find the latest chart version:

```bash
helm repo add opensearch https://opensearch-project.github.io/helm-charts
helm repo update
helm search repo opensearch-dashboard
```

Then run:

```bash
OPENSEARCH_CHART_VERSION=3.7.0 ./upgrade.sh
```

What was customized:

- opensearch-dashboards created with secretGenerator
- security plugin is disabled with a custom command for the container, we expect security on the ingress level or configured manually (in consequence `OPENSEARCH_HOSTS` is switched to http)

[opensearch-helm-charts]: https://github.com/opensearch-project/helm-charts/releases

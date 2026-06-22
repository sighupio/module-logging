# Opensearch Dashboards - maintenance

The upgrade is handled automatically by the `upgrade` task. First, find the available chart versions:

```bash
mise run chart-versions
```

Then run:

```bash
mise run upgrade 3.7.0
```

**NOTE:** the chart version here MUST be kept in sync with [`opensearch-single`](../opensearch-single/MAINTENANCE.md).

What was customized:

- opensearch-dashboards created with secretGenerator
- security plugin is disabled with a custom command for the container, we expect security on the ingress level or configured manually (in consequence `OPENSEARCH_HOSTS` is switched to http)

[opensearch-helm-charts]: https://github.com/opensearch-project/helm-charts/releases

# Logging Operated Maintenance Guide

This folder contains tailor-made files to deploy the Fluentd and Fluent-bit stack via Logging operator CRDs.

Container Images for Fluentd and Fluent-bit compatibility with logging-operator can be found here: <https://kube-logging.dev/docs/image-versions/>

The images in [`fluentd-fluentbit.yml`] and in all the `HostTailer` configs under [`configs`](../configs) are updated automatically by the `upgrade` task:

```bash
mise run upgrade-images <fluentd_version> <config_reloader_version> <fluent_bit_version>
```

**NOTE:** these image versions MUST be kept in sync with the chart version used in [`logging-operator`](../logging-operator/MAINTENANCE.md).

## Version 6.5.1 Compatible Images

For logging-operator v6.5.1, use the following compatible versions:
- **Fluentd**: `6.5.1-full` (registry.sighup.io/fury/banzaicloud/fluentd:6.5.1-full)
- **Fluent-bit**: `5.0.5` (registry.sighup.io/fury/fluent/fluent-bit:5.0.5)
- **Config-reloader**: `6.5.1` (registry.sighup.io/fury/banzaicloud/config-reloader:6.5.1)

## Grafana Dashboard

The included Grafana dashboard has been taken from: <https://raw.githubusercontent.com/kube-logging/logging-operator/master/config/dashboards/logging-dashboard.json>

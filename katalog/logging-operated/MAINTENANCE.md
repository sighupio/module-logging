# Logging Operated Maintenance Guide

This folder contains tailor-made files to deploy the Fluentd and Fluent-bit stack via Logging operator CRDs.

Container Images for Fluentd and Fluent-bit compatibility with logging-operator can be found here: <https://kube-logging.dev/docs/image-versions/>

Replace all images used in [`fluentd-fluentbit.yml`] with the ones you found in the above link.

## Version 6.5.1 Compatible Images

For logging-operator v6.5.1, use the following compatible versions:
- **Fluentd**: `6.5.1-full` (registry.sighup.io/fury/banzaicloud/fluentd:6.5.1-full)
- **Fluent-bit**: `5.0.5` (registry.sighup.io/fury/fluent/fluent-bit:5.0.5)
- **Config-reloader**: `6.5.1` (registry.sighup.io/fury/banzaicloud/config-reloader:6.5.1)

## Grafana Dashboard

The included Grafana dashboard has been taken from: <https://raw.githubusercontent.com/kube-logging/logging-operator/master/config/dashboards/logging-dashboard.json>

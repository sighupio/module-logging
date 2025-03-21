# Logging Operated Maintenance Guide

This folder contains tailor made files to deploy the Fluentd and Fluent-bit stack via Logging operator CRDs.

Container Images for Fluentd and Fluent-bit compatibility with logging-operator can be found here: <https://kube-logging.dev/docs/image-versions/>

Replace all images used in [`fluentd-fluentbit.yaml`] with the ones you found in the above link.

## Grafana Dashboard

The included Grafana dashboard has been taken from: <https://raw.githubusercontent.com/kube-logging/logging-operator/master/config/dashboards/logging-dashboard.json>

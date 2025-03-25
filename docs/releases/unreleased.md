# Logging Core Module Release v4.1.0

Welcome to the latest release of the `logging` module of [`Kubernetes Fury Distribution`](https://github.com/sighupio/fury-distribution) maintained by team SIGHUP.

This update is a major version that adds support for the Kubernetes version 1.32.

## Component Images 🚢

| Component               | Supported Version                                                                                  | Previous Version               |
| ----------------------- | -------------------------------------------------------------------------------------------------- | ------------------------------ |
| `opensearch`            | [`v2.19.1`](https://github.com/opensearch-project/OpenSearch/releases/tag/2.19.1)                  | `2.17.1`                       |
| `opensearch-dashboards` | [`v2.19.1`](https://github.com/opensearch-project/OpenSearch-Dashboards/releases/tag/2.19.1)       | `2.17.1`                       |
| `logging-operator`      | [`v5.2.0`](https://github.com/kube-logging/logging-operator/releases/tag/5.2.0)                    | `4.10.0`                       |
| `loki-distributed`      | [`v3.4.2`](https://github.com/grafana/loki/releases/tag/v3.4.2)                                    | `2.9.10`                       |
| `minio-ha`              | [`RELEASE.2025-02-28T09-55-16Z`](https://github.com/minio/minio/tree/RELEASE.2025-02-28T09-55-16Z) | `RELEASE.2024-10-13T13-34-11Z` |

## Bug Fixes and Changes 🐛

- Added support for Kubernetes version 1.32
- Updated MinIO to version `RELEASE.2025-02-28T09-55-16Z`
- Updated Logging Operator to version `5.2.0`
- Added a ServiceMonitor resource for Logging Operator
- Updated Loki to version `3.4.2`
- Updated OpenSearch and OpenSearch Dashboards images to `2.19.1`
- Added a ServiceMonitor for OpenSearch Dashboards

## Breaking Changes 💔

Starting with the v4.1.0 of the Logging Core Module Loki version has been bumped to 3.4.2. Please refer to [`loki documentation`](https://grafana.com/docs/loki/v3.4.x/setup/upgrade/)
for the complete release notes.

## Update Guide 🦮

### Before upgrading Loki from 2.9.10 to 3.4.2

When upgrading Loki the Ingester StatefulSet needs to be scaled to 2 replicas before executing the upgrade. This can be done using the following command:

```bash
kubectl scale sts -n logging loki-distributed-ingester --replicas=2
```

Once the StatefulSet has been scaled a patch needs to be applied to add the `-ingester.flush-on-shutdown=true` and the `-log.level=debug` flags on the Ingester. This will allow the ingester to flush logs that still need to be pushed to the long term storage. The patch can be applied with the following command:

```bash
kubectl patch statefulset loki-distributed-ingester -n logging --type='json' -p="[{\"op\":\"replace\",\"path\":\"/spec/template/spec/containers/0/args\",\"value\":[\"-config.file=/etc/loki/config/config.yaml\",\"-ingester.flush-on-shutdown=true\",\"-log.level=debug\",\"-target=ingester\"]}]"
```

Once the StatefulSet is stable and the patch has been applied the upgrade can be executed.

### Upgrade using the distribution

To upgrade the module using the distribution please refer to the [`official documentation`](https://docs.kubernetesfury.com/docs/upgrades/upgrades)

### Manual Upgrade

ℹ️ **Note:** Manually upgrading the module is deprecated. It is reccommended to use [`fury distribution`](https://github.com/sighupio/fury-distribution)

To upgrade the module run:

```bash
kustomize build | kubectl apply -f -
```

# Logging Core Module Release vTBD

Welcome to the latest release of the `logging` module of [`Kubernetes Fury Distribution`](https://github.com/sighupio/fury-distribution) maintained by team SIGHUP.

This update is a major version that adds support for the Kubernetes version 1.32.

## Component Images 🚢

| Component               | Supported Version                                                                                  | Previous Version               |
| ----------------------- | -------------------------------------------------------------------------------------------------- | ------------------------------ |
| `opensearch`            | [`v2.17.1`](https://github.com/opensearch-project/OpenSearch/releases/tag/2.12.0)                  | `2.12.0`                       |
| `opensearch-dashboards` | [`v2.17.1`](https://github.com/opensearch-project/OpenSearch-Dashboards/releases/tag/2.12.0)       | `2.12.0`                       |
| `logging-operator`      | [`v5.2.0`](https://github.com/kube-logging/logging-operator/releases/tag/5.2.0)                    | `5.2.0`                        |
| `loki-distributed`      | [`v2.9.10`](https://github.com/grafana/loki/releases/tag/v2.9.10)                                  | `2.9.2`                        |
| `minio-ha`              | [`RELEASE.2025-02-28T09-55-16Z`](https://github.com/minio/minio/tree/RELEASE.2025-02-28T09-55-16Z) | `RELEASE.2024-10-13T13-34-11Z` |

## Bug Fixes and Changes 🐛

- Added support for Kubernetes version 1.32
- Updated MinIO to version `RELEASE.2025-02-28T09-55-16Z`
- Updated Logging Operator to version `5.2.0`
- Added a ServiceMonitor resource for Logging Operator

## Breaking Changes 💔

None/TBD

## Update Guide 🦮

⚠ TBD

### Upgrade using the distribution

To upgrade the module using the distribution please refer to the [`official documentation`](https://docs.kubernetesfury.com/docs/upgrades/upgrades)

### Manual Upgrade

ℹ️ **Note:** Manually upgrading the module is deprecated. It is reccommended to use [`fury distribution`](https://github.com/sighupio/fury-distribution)

To upgrade the module run:

```bash
kustomize build | kubectl apply -f -
```

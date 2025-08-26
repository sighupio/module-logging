# Logging Core Module Release v5.2.0

Welcome to the latest release of the `logging` module of [`SIGHUP Distribution`](https://github.com/sighupio/distribution) maintained by team SIGHUP by ReeVo.

This release delivers enhanced logging capabilities with improved performance, Kubernetes 1.33 compatibility, and better resource management. The update brings significant improvements to log collection and processing while maintaining backward compatibility for most configurations.


## Component Images 🚢

| Component               | Supported Version                                                                                  | Previous Version               |
| ----------------------- | -------------------------------------------------------------------------------------------------- | ------------------------------ |
| `opensearch`            | [`v2.19.1`](https://github.com/opensearch-project/OpenSearch/releases/tag/2.19.1)                  | `No Update`                    |
| `opensearch-dashboards` | [`v2.19.1`](https://github.com/opensearch-project/OpenSearch-Dashboards/releases/tag/2.19.1)       | `No Update`                    |
| `logging-operator`      | [`v6.0.3`](https://github.com/kube-logging/logging-operator/releases/tag/6.0.3)                    | `v5.2.0`                       |
| `loki-distributed`      | [`v3.4.2`](https://github.com/grafana/loki/releases/tag/v3.4.2)                                    | `No Update`                    |
| `minio-ha`              | [`RELEASE.2025-02-28T09-55-16Z`](https://github.com/minio/minio/tree/RELEASE.2025-02-28T09-55-16Z) | `No Update`                    |

## New Features 🎉

### Kubernetes 1.33 Support

This release adds support for Kubernetes 1.33.x, expanding the compatibility matrix to support Kubernetes versions 1.22 through 1.33.

### Logging Operator and Logging Operated

Updated logging-operator from v5.2.0 to v6.0.3 with enhanced Kubernetes 1.33 compatibility and improved performance. The stack now includes:

- Updated Fluent Bit to v4.0.3 for better log collection
- Updated Fluentd to v6.0.3-full for enhanced log processing
- Added support for Axosyslog custom resource definition for advanced logging configurations
- Increased fluentd's default resource requests (1 CPU, 700 Mi Memory) and limits (2 CPU, 1.5 Gi Memory) based on production usage statistics
- Increased fluentbit's default requests (CPU: 100m, Memory: 100M) for better resource allocation
- Enhanced flush performance with increased flush thread counts on all output plugins

### Loki Components

Loki Distributed maintains compatibility at v3.4.2 with configuration improvements:
- Increased flush thread counts on all output plugins to improve network flush performance

### MinIO HA

Fixed a critical bug [[#189](https://github.com/sighupio/module-logging/pull/189)] where the `mc` utility image was missing the tag and defaulting to latest. This could have caused issues when upstream releases breaking changes.

## Breaking Changes 💔

- **NodeAgent CRD Removal**: The NodeAgent CRD has been deprecated and removed in logging-operator v6.0.x. All NodeAgent functionality has been replaced by HostTailer resources which provide enhanced capabilities for system log collection.

## Update Guide 🦮

### Upgrade using the distribution

To upgrade the module using the distribution please refer to the [`official documentation`](https://docs.sighup.io/docs/upgrades/upgrades)

### Manual Upgrade

ℹ️ **Note:** Manually upgrading the module is deprecated. It is recommended to use it with the [`SIGHUP Distribution`](https://github.com/sighupio/distribution).

To upgrade the module run:

```bash
kustomize build | kubectl apply -f - --server-side
```

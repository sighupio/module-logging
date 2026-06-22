# Logging Core Module Release v5.4.0

Welcome to the latest release of the `logging` module of [`SIGHUP Distribution`](https://github.com/sighupio/distribution) maintained by team SIGHUP by ReeVo.

This is a major release that adds HAProxy ingress controller logging support and improves ingress-nginx log parsing with hostname field extraction.

## Component Images 🚢

| Component               | Supported Version                                                                                             | Previous Version               |
|-------------------------|---------------------------------------------------------------------------------------------------------------|--------------------------------|
| `opensearch`            | [`v3.7.0`](https://github.com/opensearch-project/OpenSearch/releases/tag/3.7.0)                               | `v3.2.0`                      |
| `opensearch-dashboards` | [`v3.7.0`](https://github.com/opensearch-project/OpenSearch-Dashboards/releases/tag/3.7.0)                    | `v3.2.0`                       |
| `logging-operator`      | [`v6.5.1`](https://github.com/kube-logging/logging-operator/releases/tag/6.5.1)                               | `6.0.3`                        |
| `loki-distributed`      | [`v3.7.2`](https://github.com/grafana/loki/releases/tag/v3.7.2)                                               | `v3.5.3`                       |
| `minio-ha`              | [`RELEASE.2026-05-20T23-44-52Z`](https://github.com/chainguard-forks/minio/tree/RELEASE.2026-05-20T23-44-52Z) | `RELEASE.2025-09-07T16-13-09Z` |

## New Features 🎉

### HAProxy Ingress Controller Logging Support

Added new logging configurations for HAProxy ingress controller:

- `configs/ingress-haproxy`: Flow and Output configuration for OpenSearch backend
- `loki-configs/ingress-haproxy`: Flow and Output configuration for Loki backend

### Improved Ingress-Nginx Log Parsing

Enhanced ingress-nginx flow configuration to extract additional fields:

- `hostname`: The Host header from the request
- `status_code`: HTTP response status code
- `status_class`: HTTP status class (2xx, 3xx, 4xx, 5xx)

For Loki backend, these fields are now indexed as labels for improved query performance.

### Loki Distributed

This upgrade adds an `access-log-exporter` sidecar to the gateway for NGINX metrics.

### MinIO Chainguard Fork

The `minio-ha` image is now built from the [Chainguard fork](https://github.com/chainguard-forks/minio) of MinIO.

### OpenSearch Dashboards Explore

OpenSearch Dashboards 3.7.0 enables the **Explore** feature (`explore.enabled: true`), allowing users to query and visualize logs directly from the Dashboards interface.

## Breaking Changes 💔

### Ingress-Nginx Flow Regex Change

The ingress-nginx flow regex has been updated to expect a `hostname` field in the log format. This change requires module-ingress v5.0.0 or later, which outputs the `$host` field in NGINX logs.

**Compatibility:** This release requires module-ingress >= v5.0.0.

## Update Guide 🦮

### Upgrade using the distribution

To upgrade the module using the distribution please refer to the [`official documentation`](https://docs.sighup.io/docs/upgrades/upgrades)

### Manual Upgrade

ℹ️ **Note:** Manually upgrading the module is deprecated. It is recommended to use it with the [`SIGHUP Distribution`](https://github.com/sighupio/distribution).

To upgrade the module run:

```bash
kustomize build | kubectl apply -f - --server-side
```

# Logging Core Module Release vTBD

Welcome to the latest release of the `logging` module of [`SIGHUP Distribution`](https://github.com/sighupio/distribution) maintained by team SIGHUP by ReeVo.


## Component Images 🚢

| Component               | Supported Version                                                                                  | Previous Version               |
| ----------------------- | -------------------------------------------------------------------------------------------------- | ------------------------------ |
| `opensearch`            | [`v2.19.1`](https://github.com/opensearch-project/OpenSearch/releases/tag/2.19.1)                  | `No Update`                    |
| `opensearch-dashboards` | [`v2.19.1`](https://github.com/opensearch-project/OpenSearch-Dashboards/releases/tag/2.19.1)       | `No Update`                    |
| `logging-operator`      | [`v5.2.0`](https://github.com/kube-logging/logging-operator/releases/tag/5.2.0)                    | `No Update`                    |
| `loki-distributed`      | [`v3.4.2`](https://github.com/grafana/loki/releases/tag/v3.4.2)                                    | `No Update`                    |
| `minio-ha`              | [`RELEASE.2025-02-28T09-55-16Z`](https://github.com/minio/minio/tree/RELEASE.2025-02-28T09-55-16Z) | `No Update`                    |

## Bug Fixes and Changes 🐛

- [[#189](https://github.com/sighupio/module-logging/pull/189)]: Fixed a bug with `minio-ha`, where the image for the `mc` utility was missing the tag and using latest in consequence. This could lead to issues when upstream releases breaking changes.

## Breaking Changes 💔

None.

## Update Guide 🦮

### Upgrade using the distribution

To upgrade the module using the distribution please refer to the [`official documentation`](https://docs.sighup.io/docs/upgrades/upgrades)

### Manual Upgrade

ℹ️ **Note:** Manually upgrading the module is deprecated. It is recommended to use it with the [`SIGHUP Distribution`](https://github.com/sighupio/distribution).

To upgrade the module run:

```bash
kustomize build | kubectl apply -f - --server-side
```

# Logging Core Module Release TBD

Welcome to the latest release of the `logging` module of [`SIGHUP Distribution`](https://github.com/sighupio/distribution) maintained by team SIGHUP by ReeVo.


## Component Images 🚢

| Component               | Supported Version                                                                                  | Previous Version               |
| ----------------------- | -------------------------------------------------------------------------------------------------- | ------------------------------ |

## Bug Fixes and Changes 🐛

- [[#186](https://github.com/sighupio/module-logging/pull/186)]: This PR adds the retention period to Loki stack. The default retention period for logs stored in Loki is 30 days, can be customized with a patch.


## Breaking Changes 💔



## Update Guide 🦮



### Upgrade using the distribution

To upgrade the module using the distribution please refer to the [`official documentation`](https://docs.kubernetesfury.com/docs/upgrades/upgrades)

### Manual Upgrade

ℹ️ **Note:** Manually upgrading the module is deprecated. It is recommended to use it with the [`SIGHUP Distribution`](https://github.com/sighupio/distribution).

To upgrade the module run:

```bash
kustomize build | kubectl apply -f - --server-side
```

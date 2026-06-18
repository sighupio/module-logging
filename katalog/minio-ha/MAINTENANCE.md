# MinIO HA - maintenance

To maintain the MinIO package, you should follow these steps.

1. Check the latest MinIO version: https://github.com/chainguard-forks/minio/releases
2. Check the latest MC version: https://github.com/minio/mc/releases
3. Check the latest Prometheus rules version: https://github.com/samber/awesome-prometheus-alerts/releases

Then run the upgrade script:

```bash
MINIO_VERSION=RELEASE.2026-05-20T23-44-52Z MC_VERSION=RELEASE.2025-08-13T08-35-41Z PROMETHEUS_ALERTS_VERSION=2026-04-10.1 ./upgrade.sh
```

What was customized:

- Secret `minio-logging` is generated from Kustomize, so it must be removed from `minio-built.yaml`
- ConfigMap `minio-logging` is removed as it was not used
- Added a custom init job to create buckets and add 7-day retention
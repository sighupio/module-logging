# MinIO HA - maintenance

To maintain the MinIO package, you should follow these steps.

1. Take note of the latest chart version from [Main Minio repository releases](https://github.com/minio/minio/releases).
2. Take note also of the latest pushed version of both [`fury/minio`](https://registry.sighup.io/harbor/projects/37/repositories/minio/artifacts-tab`) and [`fury/minio/mc`](https://registry.sighup.io/harbor/projects/37/repositories/minio%2Fmc/artifacts-tab) images in our Harbor registry
    - If necessary, add a newer version on our [fury-distribution-container-image-sync](https://github.com/sighupio/fury-distribution-container-image-sync/blob/main/modules/dr/images.yml#L102) git repo

3. Run the following commands:

  ```bash
  VERSION=5.4.0 # update this to the latest chart version
  MINIO_TAG="RELEASE.2025-02-28T09-55-16Z" # update this to the latest fury/minio image tag
  MC_TAG="RELEASE.2025-02-21T16-00-46Z" # update this to the latest fury/minio/mc image tag
  helm repo add minio https://charts.min.io/
  helm repo update
  helm pull minio/minio --version $VERSION --untar --untardir /tmp # this command will download the chart in /tmp/minio
  helm template minio-logging /tmp/minio/ --values MAINTENANCE.values.yaml --set "image.tag"="$MINIO_TAG" --set "imageMc.tag"="$MC_TAG" -n logging > minio-built.yaml
  ```

Minio's helm comes packaged with a specific mc (its client) version, to find out
which version comes with it you can inspect `/tmp/minio/values.yaml`.

What was customized (what differs from the helm template command):

- Secret `minio-logging` is generated from Kustomize, so it must be removed from `minio-built.yaml`
- ConfigMap `minio-logging` is removed as it was not used
- Added a custom init job to create buckets and add 7 day retention

Review the differences between `minio-built.yaml` and `deploy.yaml`, make the customization described above and replace `deploy.yaml` with the contents of `minio-built.yaml`.

Cleanup:

```bash
rm minio-built.yaml
rm -rf /tmp/minio
```

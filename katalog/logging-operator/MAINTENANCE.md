# Logging Operator - maintenance

To maintain the Logging Operator package, you should follow these steps.

1. Take note of the latest chart version from [`logging-operator` chart](https://github.com/kube-logging/logging-operator/releases).
2. Take note also of the latest pushed version of the [`fury/banzaicloud/logging-operator`](https://registry.sighup.io/harbor/projects/37/repositories/banzaicloud%2Flogging-operator/artifacts-tab`) image in our Harbor registry
    - If necessary, add a newer version on our [fury-distribution-container-image-sync](https://github.com/sighupio/fury-distribution-container-image-sync/blob/main/modules/logging/images.yml#L156) git repo

3. Run the following commands:

  ```bash
  VERSION=5.2.0 # update this to the latest chart version
  IMAGE_TAG="5.2.0" # update this to the latest fury/banzaicloud/logging-operator image tag
  helm pull oci://ghcr.io/kube-logging/helm-charts/logging-operator --version $VERSION --untar --untardir /tmp # this command will download the chart in /tmp/logging-operator
  helm template logging-operator /tmp/logging-operator/ --values MAINTENANCE.values.yaml --api-versions "monitoring.coreos.com/v1" --set "image.tag"="$IMAGE_TAG" -n logging > logging-operator-built.yaml
  cp /tmp/logging-operator/crds/* ./crds
  cd ./crds; for file in $(ls logging*); do kustomize edit add resource $file 2>/dev/null; done; cd .. # ensure we add new CRDs (if any) to the kustomization file
  addlicense -c "SIGHUP s.r.l" -v -l bsd . # install with "go install github.com/google/addlicense@v1.1.1"
  ```

What was customized (what differs from the helm template command):

- Removed openshift-related permissions from ClusterRole
- Removed some labels in rbac resources

Review the differences between `logging-operator-built.yaml` and `deploy.yaml`, make the customization described above and replace `deploy.yaml` with the contents of `minio-built.yaml`.

Cleanup:

```bash
rm logging-operator-built.yaml
rm -rf /tmp/logging-operator
```

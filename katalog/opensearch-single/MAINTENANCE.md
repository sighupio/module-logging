# OpenSearch - maintenance

To maintain the OpenSearch package, you should follow these steps.

1. Take note of the latest chart version from [Opensearch Helm Charts][opensearch-helm-charts].
2. Take note also of the latest pushed version of the [`fury/opensearchproject/opensearch`](https://registry.sighup.io/harbor/projects/37/repositories/opensearchproject%2Fopensearch/artifacts-tab`) image in our Harbor registry
    - If necessary, add a newer version on our [fury-distribution-container-image-sync](https://github.com/sighupio/fury-distribution-container-image-sync/blob/main/modules/logging/images.yml#L36) git repo

3. Run the following commands:

  ```bash
  VERSION=2.32.0 # update this to the latest chart version
  IMAGE_TAG="2.19.1" # update this to the latest fury/opensearchproject/opensearch image tag
  helm repo add opensearch https://opensearch-project.github.io/helm-charts/
  helm repo update
  helm pull opensearch/opensearch --version $VERSION --untar --untardir /tmp # this command will download the chart in /tmp/opensearch
  helm template opensearch /tmp/opensearch/ --values MAINTENANCE.values.yaml --set "image.tag"="$IMAGE_TAG" -n logging > opensearch-built.yaml
  IMAGE_TAG="$IMAGE_TAG" yq -i '(.images[] | select(.name == "*opensearchproject/opensearch-dashboards")).newTag |= env(IMAGE_TAG)' kustomization.yaml
  ```

  > [!TIP]
  > Chart v2.32.0 uses OpenSearch v2.19.1

The provided values will deploy a custom `fsgroups` initContainer, because the one provided with vanilla values
does not change the `fs.file-max` value with `sysctl`.
We also added a custom sidecar container to export Prometheus metrics. We are using this strategy because the [prometheus-exporter](https://github.com/Aiven-Open/prometheus-exporter-plugin-for-opensearch) plugin is not compatible with the latest versions of OpenSearch yet.

Manual changes from the output of `helm template`:

- removed helm release labels

Then, Kustomize will automate the following changes:

- added custom prometheus AlertRules
- security plugin is disabled via ConfigMap, we expect security on the ingress level or configured manually
- change the `alpine` and `elasticsearch-exporter` images to use our Harbor registry

Cleanup:

```bash
rm opensearch-built.yaml
rm -rf /tmp/opensearch
```

[opensearch-helm-charts]: https://github.com/opensearch-project/helm-charts/releases

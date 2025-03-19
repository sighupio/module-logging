# Opensearch Dashboards - maintenance

To maintain the Opensearch Dashboards package, you should follow these steps.

1. Take note of the latest chart version from [Opensearch Helm Charts][opensearch-helm-charts].
2. Take note also of the latest pushed version of the [`fury/opensearch-dashboards`](https://registry.sighup.io/harbor/projects/37/repositories/opensearchproject%2Fopensearch-dashboards/artifacts-tab`) image in our Harbor registry
    - If necessary, add a newer version on our [fury-distribution-container-image-sync](https://github.com/sighupio/fury-distribution-container-image-sync/blob/main/modules/logging/images.yml#L36) git repo

3. Run the following commands:

  ```bash
  VERSION=2.28.0 # update this to the latest chart version
  IMAGE_TAG="2.19.1" # update this to the latest fury/opensearch-dashboards image tag
  helm repo add opensearch https://opensearch-project.github.io/helm-charts/
  helm repo update
  helm pull opensearch/opensearch-dashboards --version $VERSION --untar --untardir /tmp # this command will download the chart in /tmp/opensearch-dashboards
  helm template opensearch-dashboards /tmp/opensearch-dashboards/ --values MAINTENANCE.values.yaml --set "image.tag"="$IMAGE_TAG" -n logging > opensearch-dashboards-built.yaml
  ```

  > [!TIP]
  > Chart v2.28.0 uses OpenSearch Dashboards v2.19.1

What was customized:

- opensearch-dashboards created with secretGenerator
- security plugin is disabled with a custom command for the container, we expect security on the ingress level or configured manually (in consequence `OPENSEARCH_HOSTS` is switched to http)

Review the differences between `opensearch-dashboards-built.yaml` and `deploy.yaml`, make the customization described above and replace `deploy.yaml` with the contents of `opensearch-dashboards-built.yaml`.

Cleanup:

```bash
rm opensearch-dashboards-built.yaml
rm -rf /tmp/opensearch-dashboards
```

[opensearch-helm-charts]: https://github.com/opensearch-project/helm-charts/releases

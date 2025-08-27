<!-- markdownlint-disable MD033 MD045 -->
<h1 align="center">
<picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/sighupio/distribution/refs/heads/main/docs/assets/white-logo.png">
  <source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/sighupio/distribution/refs/heads/main/docs/assets/black-logo.png">
  <img alt="Shows a black logo in light color mode and a white one in dark color mode." src="https://raw.githubusercontent.com/sighupio/distribution/refs/heads/main/docs/assets/white-logo.png">
</picture><br/>
  Logging Module
</h1>
<!-- markdownlint-enable MD033 MD045 -->

![Release](https://img.shields.io/badge/Latest%20Release-v5.1.0-blue)
![License](https://img.shields.io/github/license/sighupio/module-logging?label=License)
![Slack](https://img.shields.io/badge/slack-@kubernetes/fury-yellow.svg?logo=slack&label=Slack)

<!-- <SD-DOCS> -->

**Logging Module** provides a logging stack for the [SIGHUP Distribution (SD)][kfd-repo].

If you are new to SD please refer to the [official documentation][kfd-docs] on how to get started with SD.

## Overview

**Logging Module** uses a collection of open source tools to provide the most resilient and robust logging stack for the cluster.

The central piece of the stack is the open source search engine [opensearch][opensearch-page], combined
with its analytics and visualization platform [opensearch-dashboards][opensearch-dashboards-page].
The logs are collected using a node-level data collection and enrichment agent [fluentbit][fluentbit-page],
pushing it to the OpenSearch via [fluentd][fluentd-page]. The fluentbit and fluentd stack is managed by Banzai Logging Operator.
We are also providing an alternative to OpenSearch: [loki][loki-page].

All the components are deployed in the `logging` namespace in the cluster.

High level diagram of the stack:

![logging module](docs/images/diagram.png "Logging Module")

## Packages

The following packages are included in the Logging module:

| Package                                                | Version                        | Description                                                                          |
| ------------------------------------------------------ | ------------------------------ | ------------------------------------------------------------------------------------ |
| [opensearch-single](katalog/opensearch-single)         | `v2.19.1`                      | Single node opensearch deployment. Not intended for production use.                  |
| [opensearch-triple](katalog/opensearch-triple)         | `v2.19.1`                      | Three node high-availability opensearch deployment                                   |
| [opensearch-dashboards](katalog/opensearch-dashboards) | `v2.19.1`                      | Analytics and visualization platform for Opensearch                                  |
| [logging-operator](katalog/logging-operator)           | `v6.0.3`                       | Banzai logging operator, manages fluentbit/fluentd and their configurations          |
| [logging-operated](katalog/logging-operated)           | `-`                            | fluentd and fluentbit deployment using logging operator                              |
| [configs](katalog/configs)                             | `-`                            | Logging pipeline configs to gather various types of logs and send them to OpenSearch |
| [loki-configs](katalog/loki-configs)                   | `-`                            | Logging pipeline configs to gather various types of logs and send them to Loki       |
| [loki-distributed](katalog/loki-distributed)           | `v3.4.2`                       | Distributed Loki deployment                                                          |
| [minio-ha](katalog/minio-ha)                           | `RELEASE.2025-02-28T09-55-16Z` | Three nodes HA MinIO deployment                                                      |

Click on each package to see its full documentation.

## Compatibility

| Kubernetes Version |   Compatibility    | Notes           |
| ------------------ | :----------------: | --------------- |
| `1.29.x`           | :white_check_mark: | No known issues |
| `1.30.x`           | :white_check_mark: | No known issues |
| `1.31.x`           | :white_check_mark: | No known issues |
| `1.32.x`           | :white_check_mark: | No known issues |
| `1.33.x`           | :white_check_mark: | No known issues |

Check the [compatibility matrix][compatibility-matrix] for additional information about previous releases of the modules.

## Usage

> [!NOTE]
> Instructions below are for deploying the module using a legacy version of furyctl, that required manual intervention and managing each module individually.
>
> Latest versions of furyctl automate the whole cluster lifecycle and it is recommended to use the latest version of furyctl instead.


### Prerequisites

| Tool                        | Version    | Description                                                                                                                                                    |
| --------------------------- | ---------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [furyctl][furyctl-repo]     | `>=0.25.0` | The recommended tool to download and manage SD modules and their packages. To learn more about `furyctl` read the [official documentation][furyctl-repo].      |
| [kustomize][kustomize-repo] | `>=3.10.0` | Packages are customized using `kustomize`. To learn how to create your customization layer with `kustomize`, please refer to the [repository][kustomize-repo]. |

### Deployment with OpenSearch

1. List the packages you want to deploy and their version in a `Furyfile.yml`

    ```yaml
    bases:
      - name: logging/opensearch-single
        version: "v5.1.0"
      - name: logging/opensearch-dashboards
        version: "v5.1.0"
      - name: logging/logging-operator
        version: "v5.1.0"
      - name: logging/logging-operated
        version: "v5.1.0"
      - name: minio/minio-ha
        version: "v5.1.0"
      - name: logging/configs
        version: "v5.1.0"
    ```

    > See `furyctl` [documentation][furyctl-repo] for additional details about `Furyfile.yml` format.

2. Execute `furyctl legacy vendor -H` to download the packages

3. Inspect the download packages under `./vendor/katalog/logging`.

4. Define a `kustomization.yaml` that includes the `./vendor/katalog/logging` directory as resource.

```yaml
resources:
- ./vendor/katalog/logging/opensearch-single
- ./vendor/katalog/logging/opensearch-dashboards
- ./vendor/katalog/logging/logging-operator
- ./vendor/katalog/logging/logging-operated
- ./vendor/katalog/logging/minio-ha
- ./vendor/katalog/logging/configs
``

5. To deploy the packages to your cluster, execute:

```bash
kustomize build . | kubectl apply --server-side -f -
```

> Note: When installing the packages, you need to ensure that the Prometheus operator is also installed.
> Otherwise, the API server will reject all ServiceMonitor resources.

### Deployment with Loki

1. List the packages you want to deploy and their version in a `Furyfile.yml`

    ```yaml
    bases:
      - name: logging/loki-distributed
        version: "v5.1.0"
      - name: logging/logging-operator
        version: "v5.1.0"
      - name: logging/logging-operated
        version: "v5.1.0"
      - name: minio/minio-ha
        version: "v5.1.0"
      - name: logging/configs
        version: "v5.1.0"
      - name: logging/loki-configs
        version: "v5.1.0"
    ```

    > See `furyctl` [documentation][furyctl-repo] for additional details about `Furyfile.yml` format.

2. Execute `furyctl legacy vendor -H` to download the packages

3. Inspect the download packages under `./vendor/katalog/logging`.

4. Define a `kustomization.yaml` that includes the `./vendor/katalog/logging` directory as resource.

```yaml
resources:
- ./vendor/katalog/logging/loki-distributed
- ./vendor/katalog/logging/logging-operator
- ./vendor/katalog/logging/logging-operated
- ./vendor/katalog/logging/minio-ha
- ./vendor/katalog/logging/loki-configs
``

5. To deploy the packages to your cluster, execute:

```bash
kustomize build . | kubectl apply --server-side -f -
```

> Note: When installing the packages, you need to ensure that the Prometheus operator is also installed.
> Otherwise, the API server will reject all ServiceMonitor resources.

### Common Customisations

#### Setup a high-availability three-node OpenSearch

Logging module offers an out of the box, highly-available setup for `opensearch` instead of a single node version. To set this up, in the `Furyfile` and `kustomization`, you can replace `opensearch-single` with `opensearch-triple`.

#### Configure tolerations and node selectors

If you need to specify tolerations and/or node selectors, you can find some snippets in [examples/tolerations](examples/tolerations) and its subfolders.

<!-- Links -->

[opensearch-page]: https://opensearch.org
[opensearch-dashboards-page]: https://opensearch.org
[fluentbit-page]: https://fluentbit.io/
[fluentd-page]: https://www.fluentd.org/
[loki-page]: https://grafana.com/oss/loki/
[kfd-repo]: https://github.com/sighupio/distribution
[furyctl-repo]: https://github.com/sighupio/furyctl
[kustomize-repo]: https://github.com/kubernetes-sigs/kustomize
[kfd-docs]: https://docs.sighup.io/docs/distribution/
[compatibility-matrix]: https://github.com/sighupio/module-logging/blob/master/docs/COMPATIBILITY_MATRIX.md

<!-- </SD-DOCS> -->

<!-- <FOOTER> -->

## Contributing

Before contributing, please read first the [Contributing Guidelines](docs/CONTRIBUTING.md).

### Reporting Issues

In case you experience any problems with the module, please [open a new issue](https://github.com/sighupio/module-logging/issues/new/choose).

## License

This module is open-source and it's released under the following [LICENSE](LICENSE)

<!-- </FOOTER> -->

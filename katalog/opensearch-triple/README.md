# OpenSearch Triple

<!-- <SD-DOCS> -->

## Overview

OpenSearch is an open source distributed search and analytics engine used for log analytics. This package deploys a high-availability, three-node OpenSearch cluster on Kubernetes for a robust and reliable setup, with each node scheduled on a different Kubernetes node.

## Upstream project

This package is based on the upstream [OpenSearch][opensearch-gh].

## Deployment

This package is deployed as part of **Logging Module** when you create a cluster with `furyctl`. You can customize it under `spec.distribution.modules.logging.opensearch` in your `furyctl.yaml` (set `opensearch.type` to `single` or `triple`). See the [module documentation](../../README.md) and the configuration reference ([EKSCluster][schema-reference-eks], [KFDDistribution][schema-reference-kfd], [OnPremises][schema-reference-onprem]) for the available options.

<!-- Links -->

[opensearch-gh]: https://github.com/opensearch-project/OpenSearch
[schema-reference-eks]: https://docs.sighup.io/docs/reference/ekscluster#specdistributionmoduleslogging
[schema-reference-kfd]: https://docs.sighup.io/docs/reference/kfddistribution#specdistributionmoduleslogging
[schema-reference-onprem]: https://docs.sighup.io/docs/reference/onpremises#specdistributionmoduleslogging

<!-- </SD-DOCS> -->

## License

For license details please see [LICENSE](../../LICENSE)

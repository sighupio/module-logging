# MinIO HA

<!-- <SD-DOCS> -->

## Overview

MinIO is a distributed object storage system. This package deploys a highly available MinIO cluster of multiple nodes, each backed by its own set of PVCs, used as the in-cluster object storage backend for the logging stack.

## Upstream project

This package is based on the upstream [MinIO][minio-gh].

## Deployment

This package is deployed as part of **Logging Module** when you create a cluster with `furyctl`. You can customize it under `spec.distribution.modules.logging.minio` in your `furyctl.yaml`. See the [module documentation](../../README.md) and the configuration reference ([EKSCluster][schema-reference-eks], [KFDDistribution][schema-reference-kfd], [OnPremises][schema-reference-onprem]) for the available options.

<!-- Links -->

[minio-gh]: https://github.com/minio/minio
[schema-reference-eks]: https://docs.sighup.io/docs/reference/ekscluster#specdistributionmoduleslogging
[schema-reference-kfd]: https://docs.sighup.io/docs/reference/kfddistribution#specdistributionmoduleslogging
[schema-reference-onprem]: https://docs.sighup.io/docs/reference/onpremises#specdistributionmoduleslogging

<!-- </SD-DOCS> -->

## License

For license details please see [LICENSE](../../LICENSE)

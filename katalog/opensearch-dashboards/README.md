# OpenSearch Dashboards

<!-- <SD-DOCS> -->

## Overview

OpenSearch Dashboards is an open source analytics and visualization platform for OpenSearch. It lets you search, view and interact with the data stored in OpenSearch indices and visualize it in charts, tables and maps.

## Upstream project

This package is based on the upstream [OpenSearch Dashboards][opensearch-dashboards-github].

## Deployment

This package is deployed as part of **Logging Module** when you create a cluster with `furyctl`. You can customize it under `spec.distribution.modules.logging.opensearch` in your `furyctl.yaml`. See the [module documentation](../../README.md) and the configuration reference ([EKSCluster][schema-reference-eks], [KFDDistribution][schema-reference-kfd], [OnPremises][schema-reference-onprem]) for the available options.

<!-- Links -->

[opensearch-dashboards-github]: https://github.com/opensearch-project/OpenSearch-Dashboards
[schema-reference-eks]: https://docs.sighup.io/docs/reference/ekscluster#specdistributionmoduleslogging
[schema-reference-kfd]: https://docs.sighup.io/docs/reference/kfddistribution#specdistributionmoduleslogging
[schema-reference-onprem]: https://docs.sighup.io/docs/reference/onpremises#specdistributionmoduleslogging

<!-- </SD-DOCS> -->

## License

For license details please see [LICENSE](../../LICENSE)

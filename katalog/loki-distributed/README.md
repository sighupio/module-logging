# Loki Distributed

<!-- <SD-DOCS> -->

## Overview

Loki is a horizontally scalable, highly available, multi-tenant log aggregation system inspired by Prometheus. It is cost-effective and easy to operate because it does not index the contents of the logs, but rather a set of labels for each log stream. This package also provides a dynamic Loki datasource that Grafana from the Monitoring Module fetches and configures automatically.

## Upstream project

This package is based on the upstream [Loki][loki-gh].

## Deployment

This package is deployed as part of **Logging Module** when you create a cluster with `furyctl`. You can customize it under `spec.distribution.modules.logging.loki` in your `furyctl.yaml`. See the [module documentation](../../README.md) and the configuration reference ([EKSCluster][schema-reference-eks], [KFDDistribution][schema-reference-kfd], [OnPremises][schema-reference-onprem]) for the available options.

<!-- Links -->

[loki-gh]: https://github.com/grafana/loki
[schema-reference-eks]: https://docs.sighup.io/docs/reference/ekscluster#specdistributionmoduleslogging
[schema-reference-kfd]: https://docs.sighup.io/docs/reference/kfddistribution#specdistributionmoduleslogging
[schema-reference-onprem]: https://docs.sighup.io/docs/reference/onpremises#specdistributionmoduleslogging

<!-- </SD-DOCS> -->

## License

For license details please see [LICENSE](../../LICENSE)

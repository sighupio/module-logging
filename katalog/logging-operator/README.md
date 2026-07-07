# Logging Operator

<!-- <SD-DOCS> -->

## Overview

The Logging Operator automates the deployment and configuration of a Kubernetes logging pipeline based on Fluentd and Fluent Bit. It deploys a Fluent Bit DaemonSet on every node to collect container and application logs from the node file system, and a Fluentd StatefulSet that receives logs from Fluent Bit and forwards them to the configured outputs.

## Upstream project

This package is based on the upstream [Logging Operator][logging-operator-github].

## Deployment

This package is deployed as part of **Logging Module** when you create a cluster with `furyctl`. You can customize it under `spec.distribution.modules.logging.operator` in your `furyctl.yaml`. See the [module documentation](../../README.md) and the configuration reference ([EKSCluster][schema-reference-eks], [KFDDistribution][schema-reference-kfd], [OnPremises][schema-reference-onprem]) for the available options.

<!-- Links -->

[logging-operator-github]: https://github.com/kube-logging/logging-operator
[schema-reference-eks]: https://docs.sighup.io/docs/reference/ekscluster#specdistributionmoduleslogging
[schema-reference-kfd]: https://docs.sighup.io/docs/reference/kfddistribution#specdistributionmoduleslogging
[schema-reference-onprem]: https://docs.sighup.io/docs/reference/onpremises#specdistributionmoduleslogging

<!-- </SD-DOCS> -->

## License

For license details please see [LICENSE](../../LICENSE)

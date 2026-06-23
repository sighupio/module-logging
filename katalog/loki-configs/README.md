# Logging operator configs for Loki

<!-- <SD-DOCS> -->

## Overview

This package is a collection of Logging Operator `Flow`/`ClusterFlow` and `Output`/`ClusterOutput` resources that route the collected logs (Kubernetes pods, infrastructural namespaces, ingress controllers, audit, events and systemd services) to **Loki**. It is mutually exclusive with the `configs` package: one excludes the other.

## Deployment

This package is deployed as part of **Logging Module** when you create a cluster with `furyctl`. See the [module documentation](../../README.md) to learn how the Logging Module is installed and configured.

<!-- </SD-DOCS> -->

## License

For license details please see [LICENSE](../../LICENSE)

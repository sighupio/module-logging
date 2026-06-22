#!/bin/bash
# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

set -euo pipefail

if [ -z "${OPENSEARCH_CHART_VERSION:-}" ]; then
  echo "Usage: OPENSEARCH_CHART_VERSION=3.7.0 ./upgrade.sh"
  exit 1
fi
echo "Using chart version ${OPENSEARCH_CHART_VERSION}"

helm template opensearch-dashboards opensearch/opensearch-dashboards \
  --values MAINTENANCE.values.yaml \
  -n logging > deploy.yaml
echo "Generated template in deploy.yaml"

OPENSEARCH_APP_VERSION=$(helm show chart opensearch/opensearch-dashboards --version ${OPENSEARCH_CHART_VERSION} | yq '.appVersion')
echo "Found app version ${OPENSEARCH_APP_VERSION}"

kustomize edit set image registry.sighup.io/fury/opensearchproject/opensearch-dashboards:${OPENSEARCH_APP_VERSION}
echo "Patched kustomization.yaml with OpenSearch Dashboards version ${OPENSEARCH_APP_VERSION}"

mise run add-license
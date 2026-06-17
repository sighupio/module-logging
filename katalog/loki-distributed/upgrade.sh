#!/bin/bash
# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

set -euo pipefail

if [ -z "${LOKI_CHART_VERSION:-}" ]; then
  echo "Usage: LOKI_CHART_VERSION=17.4.4 ./upgrade.sh"
  exit 1
fi
echo "Using chart version ${LOKI_CHART_VERSION}"

helm template loki-distributed grafana-community/loki \
  --version "${LOKI_CHART_VERSION}" \
  --values MAINTENANCE.values.yaml \
  --api-versions "monitoring.coreos.com/v1/ServiceMonitor" \
  -n logging > deploy.yaml
echo "Template generated in deploy.yaml"

yq '. | select(.kind == "Secret" and .metadata.name == "loki-distributed").data."config.yaml"' deploy.yaml | base64 -d > configs/config.yaml
for key in $(yq 'select(.kind == "ConfigMap" and .metadata.name == "loki-distributed-gateway").data | keys | .[]' deploy.yaml); do
  yq 'select(.kind == "ConfigMap" and .metadata.name == "loki-distributed-gateway").data["'$key'"]' deploy.yaml > "configs/$key"
done
echo "Extracted config files to configs/"

yq -i 'del(. | select((.kind == "ConfigMap" or .kind == "Secret") and (.metadata.name == "loki-distributed" or .metadata.name == "loki-distributed-gateway")))' deploy.yaml
echo "Removed loki Secret and gateway ConfigMap from deploy.yaml"

yq -i '(. | select(.kind == "Service" and .metadata.name == "loki-distributed-gateway").metadata.name) = "loki-stack"' deploy.yaml
echo "Renamed gateway Service to loki-stack"

LOKI_APP_VERSION=$(helm show chart grafana-community/loki --version ${LOKI_CHART_VERSION} | yq '.appVersion')
echo "Found app version ${LOKI_APP_VERSION}"

(cd dashboards && VERSION="v${LOKI_APP_VERSION}" mise run download_mixins)
echo "Downloaded Loki mixins dashboard"

mise run add-license

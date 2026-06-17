#!/bin/bash
# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

set -euo pipefail

if [ -z "${LOGGING_CHART_VERSION:-}" ]; then
  echo "Usage: LOGGING_CHART_VERSION=6.7.0 ./upgrade.sh"
  exit 1
fi
echo "Using chart version ${LOGGING_CHART_VERSION}"

rm -rf /tmp/logging-operator
helm template logging-operator oci://ghcr.io/kube-logging/helm-charts/logging-operator \
  --version "${LOGGING_CHART_VERSION}" \
  --values MAINTENANCE.values.yaml \
  --api-versions "monitoring.coreos.com/v1" \
  -n logging > deploy.yaml

yq -i 'select(.kind == "ClusterRole" and .metadata.name == "logging-operator") |= del(.rules[] | select(.apiGroups[0] == "security.openshift.io"))' deploy.yaml
echo "Removed OpenShift SCC permissions from CusterRole logging-operator"

yq -i 'select(.kind == "ClusterRole" and .metadata.name == "logging-operator-edit") |= (.metadata.labels |= with_entries(select(.key | test("^rbac"))))' deploy.yaml
echo "Filtered labels from ClusterRole logging-operator-edit"

helm pull oci://ghcr.io/kube-logging/helm-charts/logging-operator --version "${LOGGING_CHART_VERSION}" --untar --untardir /tmp
cp /tmp/logging-operator/crds/* ./crds
(cd ./crds && for f in logging*; do kustomize edit add resource "$f" 2>/dev/null; done)
echo "Copied CRDs to ./crds"

rm -rf /tmp/logging-operator
mise run add-license
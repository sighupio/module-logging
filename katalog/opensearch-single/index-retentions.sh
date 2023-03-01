#!/usr/bin/env bash
# Copyright (c) 2023 SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.
set -euo pipefail

retention_json_file=$1
opensearch_url=$2

echo "Starting tasks"
if [ -z "$retention_json_file" ]; then
  echo "Retention JSON file is not set, usage $0 <retention_json_file> <opensearch_url>"
  exit 1
fi
if [ ! -f "$retention_json_file" ]; then
  echo "File $retention_json_file does not exist, usage $0 <retention_json_file> <opensearch_url>"
  exit 1
fi

if [ -z "$opensearch_url" ]; then
  echo "OpenSearch URL is not set, usage $0 <retention_json_file> <opensearch_url>"
  exit 1
fi

function retention_policy_does_not_exist() {
    local policy_name=$1
    local opensearch_url=$2

    # shellcheck disable=SC2155
    local response=$(curl -s -XGET "$opensearch_url/_plugins/_ism/policies/$policy_name")
    if [[ "$response" == *"Policy not found"* ]]; then
        return 0
    fi
    return 1
    }

function put_retention_policy() {
  local index_name=$1
  local retention_json_file=$2
  local opensearch_url=$3

  echo "configuring retention for index $index_name"
  cp "${retention_json_file}" "${index_name}"-retention.json &&\
    sed -i "s/INDEXNAME/${index_name}/g" "${index_name}"-retention.json &&\
    sed -i "s/SNAPSHOT_MIN_AGE/${SNAPSHOT_MIN_AGE}/g" "${index_name}"-retention.json &&\
    sed -i "s/DELETE_MIN_AGE/${DELETE_MIN_AGE}/g" "${index_name}"-retention.json &&\
    curl -X PUT "${opensearch_url}/_plugins/_ism/policies/${name}" -H "Content-Type: application/json" -d @./"${name}"-retention.json
}

INDEX_NAME="kubernetes,audit,events,systemd,ingress-controller,infra"

IFS=',' read -r -a index_names <<<"$INDEX_NAME"
for name in "${index_names[@]}"; do
  if retention_policy_does_not_exist "${name}" "${opensearch_url}"; then
    put_retention_policy "${name}" "${retention_json_file}" "${opensearch_url}"
  else
    echo "retention policy for index $name already exists"
  fi
done

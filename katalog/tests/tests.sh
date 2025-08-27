#!/usr/bin/env bats
# Copyright (c) 2020 SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

# shellcheck disable=SC2154

load helper

set -o pipefail

@test "applying monitoring" {
  info
  kubectl apply -f https://raw.githubusercontent.com/sighupio/fury-kubernetes-monitoring/v3.3.1/katalog/prometheus-operator/crds/0podmonitorCustomResourceDefinition.yaml
  kubectl apply -f https://raw.githubusercontent.com/sighupio/fury-kubernetes-monitoring/v3.3.1/katalog/prometheus-operator/crds/0prometheusruleCustomResourceDefinition.yaml
  kubectl apply -f https://raw.githubusercontent.com/sighupio/fury-kubernetes-monitoring/v3.3.1/katalog/prometheus-operator/crds/0servicemonitorCustomResourceDefinition.yaml
  kubectl apply -f https://raw.githubusercontent.com/sighupio/fury-kubernetes-monitoring/v3.3.1/katalog/prometheus-operator/crds/0probeCustomResourceDefinition.yaml
}

@test "testing logging-operator apply" {
  info
  apply katalog/logging-operator
}

@test "testing opensearch-single apply" {
  info
  apply katalog/opensearch-single
}

@test "testing logging-operated apply" {
  info
  apply katalog/logging-operated
}

@test "testing kubernetes config apply" {
  info
  apply katalog/configs/kubernetes
}

@test "testing opensearch-dashboards apply" {
  info
  apply katalog/opensearch-dashboards
}

@test "wait for apply to settle and dump state to dump.json (1)" {
  info
  max_retry=0
  echo "=====" $max_retry "=====" >&2
  while kubectl get pods --all-namespaces | grep -ie "\(Pending\|Error\|CrashLoop\|ContainerCreating\|PodInitializing\)" >&2
  do
    [ $max_retry -lt 60 ] || ( kubectl describe all --all-namespaces >&2 && return 1 )
    sleep 10 && echo "# waiting..." $max_retry >&3
    max_retry=$((max_retry+1))
  done
}

@test "check opensearch-single" {
  info
  test(){
    check_sts_ready "opensearch-cluster-master" "logging"
  }
  loop_it test 60 5
  status=${loop_it_result}
  [[ "$status" -eq 0 ]]
}

@test "check fluentbit" {
  info
  test(){
    check_ds_ready "infra-fluentbit" "logging"
  }
  loop_it test 60 5
  status=${loop_it_result}
  [[ "$status" -eq 0 ]]
}

@test "check fluentd" {
  info
  test(){
    check_sts_ready "infra-fluentd" "logging"
  }
  loop_it test 60 5
  status=${loop_it_result}
  [[ "$status" -eq 0 ]]
}

@test "check opensearch-dashboards" {
  info
  test(){
    check_deploy_ready "opensearch-dashboards" "logging"
  }
  loop_it test 400 6
  status=${loop_it_result}
  [[ "$status" -eq 0 ]]
}

@test "check output kubernetes" {
  info
  test(){
    data=$(kubectl get clusteroutput -n logging | grep kubernetes | grep true)
    if [ "${data}" == "" ]; then return 1; fi
  }
  loop_it test 400 6
  status=${loop_it_result}
  [[ "$status" -eq 0 ]]
}

@test "testing loki-distributed apply" {
  info
  apply katalog/loki-distributed
}

@test "testing minio-ha apply" {
  info
  apply katalog/minio-ha
}

@test "testing infra config (with loki) apply" {
  info
  apply katalog/loki-configs/infra
}

@test "wait for apply to settle and dump state to dump.json (2)" {
  info
  max_retry=0
  echo "=====" $max_retry "=====" >&2
  while kubectl get pods --all-namespaces | grep -ie "\(Pending\|Error\|CrashLoop\|ContainerCreating\|PodInitializing\)" >&2
  do
    [ $max_retry -lt 60 ] || ( kubectl describe all --all-namespaces >&2 && return 1 )
    sleep 10 && echo "# waiting..." $max_retry >&3
    max_retry=$((max_retry+1))
  done
}

@test "check loki-distributed ingester" {
  info
  test(){
    check_sts_ready "loki-distributed-ingester" "logging"
  }
  loop_it test 400 6
  status=${loop_it_result}
  [[ "$status" -eq 0 ]]
}

@test "check loki-distributed querier" {
  info
  test(){
    check_deploy_ready "loki-distributed-querier" "logging"
  }
  loop_it test 400 6
  status=${loop_it_result}
  [[ "$status" -eq 0 ]]
}

@test "check loki-distributed query-scheduler" {
  info
  test(){
    check_deploy_ready "loki-distributed-query-scheduler" "logging"
  }
  loop_it test 400 6
  status=${loop_it_result}
  [[ "$status" -eq 0 ]]
}

@test "check loki-distributed index-gateway" {
  info
  test(){
    check_sts_ready "loki-distributed-index-gateway" "logging"
  }
  loop_it test 400 6
  status=${loop_it_result}
  [[ "$status" -eq 0 ]]
}

@test "check minio-ha" {
  info
  test(){
    check_sts_ready "minio-logging" "logging"
  }
  loop_it test 400 6
  status=${loop_it_result}
  [[ "$status" -eq 0 ]]
}

@test "check minio setup job" {
  info
  test(){
    check_job_ready "minio-logging-buckets-setup" "logging"
  }
  loop_it test 400 6
  status=${loop_it_result}
  [[ "$status" -eq 0 ]]
}

@test "check output infra" {
  info
  test(){
    data=$(kubectl get clusteroutput -n logging | grep infra | grep true)
    if [ "${data}" == "" ]; then return 1; fi
  }
  loop_it test 400 6
  status=${loop_it_result}
  [[ "$status" -eq 0 ]]
}

@test "cleanup" {
  if [ -z "${LOCAL_DEV_ENV}" ];
  then
    skip
  fi
  for dir in opensearch-single fluentd opensearch-dashboards
  do
    echo "# deleting katalog/$dir" >&3
    kustomize build katalog/$dir | kubectl delete -f - || true
    echo "# deleted katalog/$dir" >&3
  done
}

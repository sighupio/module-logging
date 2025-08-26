#!/usr/bin/env bats

# shellcheck disable=SC2086,SC2154,SC2034

set -o pipefail

kaction(){
    path=$1
    verb=$2
    kustomize build $path | kubectl $verb -f -
}

apply (){
  kustomize build $1 >&2
  kustomize build $1 | kubectl apply -f - --server-side 2>&3
}

delete (){
  kustomize build $1 >&2
  kustomize build $1 | kubectl delete -f - 2>&3
}

info(){
  echo -e "${BATS_TEST_NUMBER}: ${BATS_TEST_DESCRIPTION}" >&3
}

loop_it(){
  retry_counter=0
  max_retry=${2:-100}
  wait_time=${3:-2}
  run ${1}
  ko=${status}
  loop_it_result=${ko}
  while [[ ko -ne 0 ]]
  do
    if [ $retry_counter -ge $max_retry ]; then echo "Timeout waiting a condition"; return 1; fi
    sleep ${wait_time} && echo "# waiting..." $retry_counter >&3
    run ${1}
    ko=${status}
    loop_it_result=${ko}
    retry_counter=$((retry_counter + 1))
  done
  return 0
}

check_sts_ready() {
  local name=$1
  local namespace=$2
  local replicas ready_replicas
  replicas=$(kubectl get sts "$name" -n "$namespace" -o jsonpath='{.status.replicas}' 2>/dev/null || echo "0")
  ready_replicas=$(kubectl get sts "$name" -n "$namespace" -o jsonpath='{.status.readyReplicas}' 2>/dev/null || echo "0")
  [ "$replicas" -eq "$ready_replicas" ] && [ "$replicas" -gt 0 ]
}

check_ds_ready() {
  local name=$1
  local namespace=$2
  local desired ready
  desired=$(kubectl get ds "$name" -n "$namespace" -o jsonpath='{.status.desiredNumberScheduled}' 2>/dev/null || echo "0")
  ready=$(kubectl get ds "$name" -n "$namespace" -o jsonpath='{.status.numberReady}' 2>/dev/null || echo "0")
  [ "$desired" -eq "$ready" ] && [ "$desired" -gt 0 ]
}

check_deploy_ready() {
  local name=$1
  local namespace=$2
  local replicas ready_replicas
  replicas=$(kubectl get deploy "$name" -n "$namespace" -o jsonpath='{.status.replicas}' 2>/dev/null || echo "0")
  ready_replicas=$(kubectl get deploy "$name" -n "$namespace" -o jsonpath='{.status.readyReplicas}' 2>/dev/null || echo "0")
  [ "$replicas" -eq "$ready_replicas" ] && [ "$replicas" -gt 0 ]
}

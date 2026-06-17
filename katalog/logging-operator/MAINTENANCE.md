# Logging Operator - maintenance

To maintain the Logging Operator package, you should follow these steps.

1. Take note of the latest chart version from [`logging-operator` chart](https://github.com/kube-logging/logging-operator/releases). 
   - If necessary, add a newer version on our [container-image-sync](https://github.com/sighupio/container-image-sync/blob/main/modules/logging/images.yml) git repo
   - **NOTE:** the chart version here MUST be kept in sync with the data plane images used in [`../logging-operated/`](../logging-operated/MAINTENANCE.md).

2. Run the upgrade script, specifying the desired chart version:
   ```bash
   LOGGING_CHART_VERSION=6.5.1 ./upgrade.sh
   ```

What was customized (what differs from the helm template command):

- Removed openshift-related permissions from ClusterRole
- Removed some labels in rbac resources

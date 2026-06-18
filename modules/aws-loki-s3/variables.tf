# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

variable "bucket_name" {
  type        = string
  description = "The name of the dedicated S3 bucket to create for Loki storage"
}

variable "oidc_provider_url" {
  type        = string
  description = "The OIDC provider URL for IRSA"
}

variable "cluster_name" {
  type        = string
  description = "The EKS cluster name"
}

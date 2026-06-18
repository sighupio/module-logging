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

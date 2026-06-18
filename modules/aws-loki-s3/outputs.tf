# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

output "loki_iam_role_arn" {
  value = aws_iam_role.loki.arn
}

output "loki_s3_bucket_name" {
  value = aws_s3_bucket.loki.id
}

output "loki_s3_bucket_arn" {
  value = aws_s3_bucket.loki.arn
}

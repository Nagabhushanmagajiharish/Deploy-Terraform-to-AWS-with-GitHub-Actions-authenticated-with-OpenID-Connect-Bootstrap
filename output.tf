output "github_actions_role_arn" {
  description = "IAM role ARN to use in GitHub Actions."
  value       = aws_iam_role.github_actions.arn
}

output "s3_bucket_name" {
  description = "Name of the demo S3 bucket."
  value       = aws_s3_bucket.example.id
}

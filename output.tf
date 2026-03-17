output "github_actions_role_arn" {
  description = "IAM role ARN to use in GitHub Actions."
  value       = aws_iam_role.github_actions.arn
}

output "github_oidc_provider_arn" {
  description = "IAM OIDC provider ARN used by GitHub Actions."
  value       = aws_iam_openid_connect_provider.github.arn
}

output "terraform_state_bucket_name" {
  value = aws_s3_bucket.tf_state.bucket
}
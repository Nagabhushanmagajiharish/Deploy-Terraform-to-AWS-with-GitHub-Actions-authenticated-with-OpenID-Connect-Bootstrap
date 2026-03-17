variable "aws_region" {
  description = "AWS region used by Terraform and GitHub Actions."
  type        = string
  default     = "eu-west-2"
}

variable "github_owner" {
  description = "GitHub owner or organization that hosts this repository."
  type        = string
  default     = "Nagabhushanmagajiharish"
}

variable "github_repo" {
  description = "GitHub repository name used in the OIDC trust policy."
  type        = string
  default     = "Deploy-Terraform-to-AWS-with-GitHub-Actions-authenticated-with-OpenID-Connect"
}

variable "terraform_state_bucket_name" {
  description = "S3 bucket used for Terraform remote state."
  type        = string
  default     = "my-project-oidc"
}

variable "app_bucket_name" {
  description = "Application bucket managed by the infra stack."
  type        = string
  default     = "nagabhushan-oidc-app-061039787667-01"
}

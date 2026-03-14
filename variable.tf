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

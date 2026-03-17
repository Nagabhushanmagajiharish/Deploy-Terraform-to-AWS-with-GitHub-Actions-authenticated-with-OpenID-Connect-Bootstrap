resource "aws_s3_bucket" "tf_state" {
  bucket = var.terraform_state_bucket_name

  tags = {
    Name = var.terraform_state_bucket_name
  }
}

resource "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = ["sts.amazonaws.com"]
}


data "aws_iam_policy_document" "github_oidc" {
  statement {
    effect = "Allow"

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github.arn]
    }

    actions = ["sts:AssumeRoleWithWebIdentity"]

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    # Allow runs from pushes to main and pull requests in this repository.
    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values = [
        "repo:Nagabhushanmagajiharish/Deploy-Terraform-to-AWS-with-GitHub-Actions-authenticated-with-OpenID-Connect:ref:refs/heads/main",
        "repo:Nagabhushanmagajiharish/Deploy-Terraform-to-AWS-with-GitHub-Actions-authenticated-with-OpenID-Connect:pull_request",
        "repo:Nagabhushanmagajiharish/Deploy-Terraform-to-AWS-with-GitHub-Actions-authenticated-with-OpenID-Connect:environment:production",
        "repo:Nagabhushanmagajiharish/Deploy-Terraform-to-AWS-with-GitHub-Actions-authenticated-with-OpenID-Connect-Bootstrap:ref:refs/heads/main",
        "repo:Nagabhushanmagajiharish/Deploy-Terraform-to-AWS-with-GitHub-Actions-authenticated-with-OpenID-Connect-Bootstrap:pull_request",
      ]
    }
  }
}

resource "aws_iam_role" "github_actions" {
  name               = "github-actions-oidc-role"
  assume_role_policy = data.aws_iam_policy_document.github_oidc.json
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tf_state" {
  bucket = aws_s3_bucket.tf_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "tf_state" {
  bucket                  = aws_s3_bucket.tf_state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

data "aws_iam_policy_document" "terraform_state_access" {
  statement {
    effect = "Allow"
    actions = [
      "s3:ListBucket"
    ]
    resources = [aws_s3_bucket.tf_state.arn]
  }

  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]
    resources = [
      "${aws_s3_bucket.tf_state.arn}/*"
    ]
  }
}

resource "aws_iam_role_policy" "terraform_state_access" {
  name   = "terraform-state-access"
  role   = aws_iam_role.github_actions.id
  policy = data.aws_iam_policy_document.terraform_state_access.json
}


data "aws_iam_policy_document" "github_actions_permissions" {
  statement {
    sid    = "TerraformStateBucketList"
    effect = "Allow"

    actions = [
      "s3:ListBucket"
    ]

    resources = [
      "arn:aws:s3:::${var.terraform_state_bucket_name}"
    ]
  }

  statement {
    sid    = "TerraformStateObjects"
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]

    resources = [
      "arn:aws:s3:::${var.terraform_state_bucket_name}/*"
    ]
  }

  statement {
    sid    = "ManageInfraS3Buckets"
    effect = "Allow"

    actions = [
      "s3:CreateBucket",
      "s3:DeleteBucket",
      "s3:DeleteBucket*",
      "s3:GetBucket*",
      "s3:PutBucket*",
      "s3:GetEncryptionConfiguration",
      "s3:PutEncryptionConfiguration",
      "s3:GetLifecycleConfiguration",
      "s3:PutLifecycleConfiguration",
      "s3:GetReplicationConfiguration",
      "s3:PutReplicationConfiguration",
      "s3:ListBucket"
    ]

    resources = [
      "arn:aws:s3:::${var.app_bucket_name}"
    ]
  }
}

resource "aws_iam_role_policy" "github_actions_permissions" {
  name   = "github-actions-terraform-permissions"
  role   = aws_iam_role.github_actions.id
  policy = data.aws_iam_policy_document.github_actions_permissions.json
}

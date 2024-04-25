data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam-role" {
  name               = "iam-role-lambda-api-gateway"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}
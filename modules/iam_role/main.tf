# ref https://github.com/tmknom/example-pragmatic-terraform/blob/master/05/iam_role/7.tf
#
#  Replaced default -> main
#  Separated into main.tf, variable.tf and output.tf 
#
resource "aws_iam_role" "main" {
  name               = var.name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = [var.identifier]
    }
  }
}

resource "aws_iam_policy" "main" {
  name   = var.name
  policy = var.policy
}

resource "aws_iam_role_policy_attachment" "main" {
  role       = aws_iam_role.main.name
  policy_arn = aws_iam_policy.main.arn
}
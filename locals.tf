locals {
  account_id = data.aws_caller_identity.current_account.id
  region     = data.aws_region.current_region.name
  aws_ecr_url             = "${local.account_id}.dkr.ecr.${var.region}.amazonaws.com"
}
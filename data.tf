data "aws_region" "current_region" {}
data "aws_caller_identity" "current_account" {}
data "aws_ecr_authorization_token" "token" {}
data "aws_vpc" "app-vpc" {
  id = var.vpc_id
}
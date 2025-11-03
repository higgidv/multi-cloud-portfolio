terraform {
  backend "s3" {
    bucket         = "healthcare-dr-terraform-state-903236527011"
    key            = "aws/primary/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    kms_key_id     = "alias/terraform-state"
    dynamodb_table = "terraform-state-lock"
  }
}
terraform {
  backend "s3" {
    bucket         = "postech-5soat-grupo-25-tfstate"
    dynamodb_table = "postech-5soat-grupo-25-tflocks"
    key            = "infra/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}

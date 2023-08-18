variable "region" {
  description = "The AWS region where resources will be created."
  default     = "us-east-1"
}

variable "public_key" {
  description = "The public SSH key used for instance authentication."
}

variable "private_key" {
  description = "The private SSH key corresponding to the public key."
}

variable "key_name" {
  description = "The name of the AWS EC2 key pair."
}


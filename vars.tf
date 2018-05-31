variable "AWS_REGION" {
  default = "us-east-1"
}
variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}
variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}
variable "ECS_INSTANCE_TYPE" {
  default = "t2.medium"
}
variable "ECS_AMIS" {
  type = "map"
  default = {
    us-east-1 = "ami-5253c32d"
  }
}

variable "image_tag"  {}

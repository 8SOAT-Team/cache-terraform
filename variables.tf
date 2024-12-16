variable "region" {
  default  = "us-east-1"
  type     = string
  nullable = false
}

variable "vpcCidr" {
  default = "172.31.0.0/16"
}
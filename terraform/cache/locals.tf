locals {
  region = "us-east-1"
  name   = "ex-${basename(path.cwd)}"

  vpc_cidr = data.terraform_remote_state.network.outputs.vpc_cidr_block
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)

  tags = {
    Name = local.name
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}
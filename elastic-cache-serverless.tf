resource "aws_elasticache_serverless_cache" "redis_serverless" {
  engine = "redis"
  name   = "soat-cache"
  cache_usage_limits {
    data_storage {
      maximum = 10
      unit    = "GB"
    }
    ecpu_per_second {
      maximum = 5000
    }
  }
  daily_snapshot_time      = "09:00"
  description              = "Fast Order Cache"
  kms_key_id               = aws_kms_key.this.arn
  major_engine_version     = "7"
  snapshot_retention_limit = 1
  security_group_ids       = [aws_security_group.soat-cache-sg.id]
  subnet_ids               = [for subnet in data.aws_subnet.subnet : subnet.id if subnet.availability_zone == "${var.region}a" || subnet.availability_zone == "${var.region}b"]
}



resource "aws_kms_key" "this" {
  description         = "KMS CMK for ${local.name}"
  enable_key_rotation = true

  tags = local.tags
}

resource "aws_security_group" "soat-cache-sg" {
  name   = "SG-soat-cache"
  vpc_id = data.aws_vpc.vpc.id

  ingress {
    description = "All-6379"
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "All-6380"
    from_port   = 6380
    to_port     = 6380
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "All"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name       = "redis-subnet-group"
  subnet_ids = data.terraform_remote_state.network.outputs.public_subnet_ids

  tags = {
    Name = "Redis Subnet Group"
  }
}

resource "aws_elasticache_replication_group" "redis" {
  replication_group_id          = "soat-cache"
  description                   = "soat-redis"
  engine                        = "redis"
  engine_version                = "7.0"
  node_type                     = "cache.t4g.micro"
  num_node_groups               = 1
  replicas_per_node_group       = 0
  automatic_failover_enabled    = false
  security_group_ids            = [data.terraform_remote_state.network.outputs.aws_security_group_id]
  subnet_group_name             = aws_elasticache_subnet_group.redis_subnet_group.name
  snapshot_retention_limit      = 0
  tags                          = {
    Name        = "Redis Test Cluster"
  }
}

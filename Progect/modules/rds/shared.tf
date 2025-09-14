# Subnet group (used by both RDS and Aurora)
resource "aws_db_subnet_group" "this" {
  name       = "${var.name}-subnet-group"
  subnet_ids = var.publicly_accessible ? var.subnet_public_ids : var.subnet_private_ids

  tags = merge(var.tags, {
    Name = "${var.name}-subnet-group"
  })
}

# Security group (used by both RDS and Aurora)
resource "aws_security_group" "this" {
  name        = "${var.name}-sg"
  description = "Security group for RDS/Aurora"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # for simplicity
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "${var.name}-sg"
  })
}

# Parameter group for standard RDS
resource "aws_db_parameter_group" "rds" {
  count       = var.use_aurora ? 0 : 1
  name        = "${var.name}-rds-params"
  family      = var.parameter_group_family_rds
  description = "Parameter group for RDS ${var.name}"

  dynamic "parameter" {
    for_each = var.parameters
    content {
      name         = parameter.key
      value        = parameter.value
      apply_method = "pending-reboot"
    }
  }

  tags = var.tags
}

# Parameter group for Aurora
resource "aws_rds_cluster_parameter_group" "aurora" {
  count       = var.use_aurora ? 1 : 0
  name        = "${var.name}-aurora-params"
  family      = var.parameter_group_family_aurora
  description = "Parameter group for Aurora ${var.name}"

  dynamic "parameter" {
    for_each = var.parameters
    content {
      name         = parameter.key
      value        = parameter.value
      apply_method = "pending-reboot"
    }
  }

  tags = var.tags
}
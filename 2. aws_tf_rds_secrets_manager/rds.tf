data "aws_secretsmanager_secret" "example" {
  name = "rds_admin6"
  depends_on = [
    aws_secretsmanager_secret.example
  ]
}

data "aws_secretsmanager_secret_version" "secret" {
  secret_id = data.aws_secretsmanager_secret.example.id
}

resource "aws_db_instance" "default" {
  identifier              = "my-database"
  allocated_storage       = var.allocated_storage
  storage_type            = "gp2"
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  username                = "Admin"
  password                = data.aws_secretsmanager_secret_version.secret.secret_string
  parameter_group_name    = "default.mariadb10.4"
  skip_final_snapshot     = true
  publicly_accessible     = true
  multi_az                = false
  storage_encrypted       = true
  backup_retention_period = 7

  tags = {
    Name = var.default_tag
  }
}
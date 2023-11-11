resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_!%^"
}

resource "aws_secretsmanager_secret" "example" {
  kms_key_id              = aws_kms_key.default.key_id
  name                    = "rds_admin6"
  description             = "RDS Admin password"
  recovery_window_in_days = 14

  tags = {
    Name = var.default_tag
  }
}

resource "aws_secretsmanager_secret_version" "secret" {
  secret_id     = aws_secretsmanager_secret.example.id
  secret_string = random_password.password.result
}
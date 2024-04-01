resource "aws_ecs_cluster" "ECS" {
  name = "my-cluster"

  tags = {
    Name = "my-new-cluster"
  }
}   
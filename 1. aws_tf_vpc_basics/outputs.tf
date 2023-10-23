output "dev_id" {
  value = aws_instance.MyEc2Instance.public_ip
}
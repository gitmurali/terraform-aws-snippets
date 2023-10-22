data "aws_ami" "example" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

resource "aws_instance" "MyEc2Instance" {
  ami                    = data.aws_ami.example.id
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.auth.id
  vpc_security_group_ids = ["${aws_security_group.allow_sgs.id}"]
  subnet_id              = aws_subnet.main.id
  user_data              = file("${path.module}/userdata.tpl")

  root_block_device { 
    volume_size = 10
  }

  tags = {
    Name = "dev-node"
  }
}
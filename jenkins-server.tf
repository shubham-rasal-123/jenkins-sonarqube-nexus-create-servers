
resource "aws_instance" "jenkins-server" {
  ami                  = data.aws_ami.latest.id
  instance_type        = "c7i-flex.large"
  subnet_id            = aws_subnet.our-public-subnet1.id
  user_data            = file("./jenkins-server.sh")
  key_name             = "jenkins-server"
  iam_instance_profile = aws_iam_instance_profile.our-instance-profile.name
  security_groups      = [aws_security_group.our-security-group.id]
  root_block_device {
    volume_size = 20
  }

  tags = {
    Name = "jenkins-server"
  }
}

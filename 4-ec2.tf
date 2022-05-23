/*
resource "aws_instance" "test_server" {
  ami           = "ami-08d70e59c07c61a3a"
  instance_type = "t2.micro"

  tags = {
    Name = "${var.project}-ec2-test"
  }
}
*/
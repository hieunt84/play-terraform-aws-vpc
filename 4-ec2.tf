/*
resource "aws_instance" "test_server" {
  ami           = "ami-08d70e59c07c61a3a"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public[0].id

  tags = {
    Name = "${var.project}-ec2-test"
  }
}
*/

/*
resource "aws_instance" "test_server" {
  ami           = "ami-0ca285d4c2cda3300"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.private[0].id

  tags = {
    Name = "${var.project}-ec2-test"
  }
}
*/

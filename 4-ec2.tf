
# EC2 IAM Role access System Manager
resource "aws_iam_role" "ec2tosm" {
  name = "${var.project}-ec2tosm-Role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "ec2_AmazonEC2RoleforSSM" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2RoleforSSM"
  role       = aws_iam_role.ec2tosm.name
}

/*
#############################################
resource "aws_instance" "test_server" {
  ami           = "ami-0ca285d4c2cda3300"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.private[0].id

  tags = {
    Name = "${var.project}-ec2-test"
  }
}
*/

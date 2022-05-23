
# EC2 IAM Role access Servie System Manager
resource "aws_iam_role" "ec2tossm" {
  name = "${var.project}-ec2tossm-Role"

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

#Attach role to policy
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment
resource "aws_iam_role_policy_attachment" "ec2_AmazonEC2RoleforSSM" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
  role       = aws_iam_role.ec2tossm.name
}

#Attach role to an instance profile
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_profile"
  role = aws_iam_role.ec2tossm.name
}

# Security group for ec2
resource "aws_security_group" "ec2_sg" {
  name   =  "${var.project}-ec2-sg"
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.project}-ecs-sg"
  }
}

# Security group traffic rules
resource "aws_security_group_rule" "ec2_inbound" {
  security_group_id = aws_security_group.ec2_sg.id
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ec2_outbound" {
  security_group_id = aws_security_group.ec2_sg.id
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}


#############################################
resource "aws_instance" "test_server" {
  ami           = "ami-0ca285d4c2cda3300"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.ec2-sg.id]
  subnet_id = aws_subnet.private[0].id
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name
  tags = {
    Name = "${var.project}-ec2-test"
  }
}


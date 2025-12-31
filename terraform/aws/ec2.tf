resource "aws_security_group" "devops_sg" {
  name        = "devops-prod-sg"
  description = "Security group for DevOps EC2 instance"
  vpc_id      = aws_vpc.devops_vpc.id

  ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "devops-prod-sg"
  }
}


resource "aws_iam_instance_profile" "devops_instance_profile" {
  name = "devops-prod-instance-profile"
  role = aws_iam_role.devops_role.name
}

resource "aws_instance" "devops_ec2" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"
  subnet_id 	= aws_subnet.public_subnet.id

  iam_instance_profile = aws_iam_instance_profile.devops_instance_profile.name
  vpc_security_group_ids = [
    aws_security_group.devops_sg.id
  ]

  tags = {
    Name = "devops-prod-ec2"
  }
}


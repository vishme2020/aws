provider "aws" {
access_key = "AKIA323KI72RRSPNI5XJ"
secret_key = "t2g2B4FK9mTV6gk5K4BEK4rrsWvn8rTCwMx69x8b"
region = "ap-south-1"
}
resource "aws_instance" "example" {
  ami           = "ami-0123b531fc646552f"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id] 
  key_name = "sathi"
    user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF


tags = {
    Name = "t-vm1"
  }
}

resource "aws_security_group" "instance" {
  name = "t-asg1"
  ingress {
    from_port   = ["8080", "22"]
    to_port     = ["8080", "22"]
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


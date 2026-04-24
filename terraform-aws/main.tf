# 1. Tell Terraform we are using AWS
provider "aws" {
  region = "us-east-1"
}

# 2. Create a "Security Group" (A firewall)
resource "aws_security_group" "boutique_sg" {
  name        = "boutique-security-group"
  description = "Allow web and ssh traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  ingress {
    from_port   = 30081
    to_port     = 30081
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  ingress {
    from_port   = 30080
    to_port     = 30080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] 
  }
}

# 3. Create the actual Server (EC2)
resource "aws_instance" "boutique_server" {
  ami           = "ami-0c7217cdde317cfec" # Ubuntu 22.04 LTS
  instance_type = "t3.small"
  key_name      = "my-project-key"        # The key pair you just created
  
  vpc_security_group_ids = [aws_security_group.boutique_sg.id]

  tags = {
    Name = "OnlineBoutiqueServer"
  }

  # Root volume sizing
  root_block_device {
    volume_size = 20 # 20 GB is enough for this lab
  }
}

# 4. Show the IP address of the server when it's done
output "server_public_ip" {
  value = aws_instance.boutique_server.public_ip
}

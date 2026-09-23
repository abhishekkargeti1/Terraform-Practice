# Key pair 
resource "aws_key_pair" "ssh_key" {
  key_name   = "${var.env}-ssh-key"           # First generate key change the key name as per your key file name 
  public_key = file("ssh-key.pub") # change the key name as per your key file name 
  tags = {
    Environment=var.env
  }
}


# VPC & Security Group
resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

resource aws_security_group my_security_group {
  name        = "${var.env}-my_security_group"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_default_vpc.default.id # interpolation

  # inbound Rule / ingress
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Ssh Configured"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP Configured"
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP Configured"
  }

  # outbound Rule / egress
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "All Access Configured"
  }

  tags = {
    Name = "${var.env}-my_security_group"
    Environment=var.env
  }
}

# ec2 Instance

resource "aws_instance" "myFirstEc2" {

  depends_on = [ aws_security_group.my_security_group ]
  // count = 2 # This is meta data / count is use to create n number of instance 

  for_each = ({
    Terraform_Automate_EC2_1 = "t2.micro"
    Terraform_Automate_EC2_2 = "t2.micro"
  }) #  This is meta argument

  key_name        = aws_key_pair.ssh_key.key_name
  security_groups = [aws_security_group.my_security_group.name]
  #instance_type = var.ec2_instance_type
  instance_type = each.value
  ami           = var.ec2_instance_ami
  user_data     = file("install.sh")
  root_block_device {
    # volume_size =  var.ec2_default_instance_storage  Without Condition
    volume_size = var.env == "dev" ? 1001 : var.ec2_default_instance_storage # With Condition
    volume_type = "gp3"
  }

  tags = {
    // Name= "Terraform_Automate_EC2"
    Name = each.key
    Environment=var.env
  }
}



# resource aws_instance my_new_instance {
#   ami = "unknown"
#   instance_type = "unknown"
  
# }
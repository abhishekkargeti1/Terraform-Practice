variable "env" {
  default = "dev"
  type = string
}


variable "ec2_instance_type" {
  default = "t3.xlarge"
  type    = string
}

variable "ec2_default_instance_storage" {
  default = 1000
  type    = number
}

variable "ec2_instance_ami" {
  default = "ami-0b6d9d3d33ba97d99" # ubuntu
  type    = string
}

# Single Output / mulitiple for count meta argument

# output ec2_public_ip {
#   value = aws_instance.myFirstEc2[*].public_ip
# }

# output ec2_public_dns {
#   value = aws_instance.myFirstEc2[*].public_dns
# }

# output ec2_private_ip {
#   value = aws_instance.myFirstEc2[*].private_ip
# }




# For Each meta argument Output 

output "ec2_public_ip" {
  value = { for k, v in aws_instance.myFirstEc2 : k => v.public_ip }
}

output "ec2_public_dns" {
  value = { for k, v in aws_instance.myFirstEc2 : k => v.public_dns }
}

output "ec2_private_ip" {
  value = { for k, v in aws_instance.myFirstEc2 : k => v.private_ip }
}
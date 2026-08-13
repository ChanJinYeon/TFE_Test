output "default_vpc_id" {
  description = "Default VPC ID"
  value       = data.aws_vpc.default.id
}

output "selected_subnet_id" {
  description = "Subnet used for test EC2"
  value       = sort(data.aws_subnets.default.ids)[0]
}

output "ami_id" {
  description = "Amazon Linux 2023 AMI ID"
  value       = data.aws_ami.amazon_linux_2023.id
}

output "instance_ids" {
  description = "Created EC2 instance IDs"
  value       = aws_instance.test[*].id
}

output "instance_private_ips" {
  description = "Created EC2 private IP addresses"
  value       = aws_instance.test[*].private_ip
}

output "good_security_group_id" {
  description = "GOOD Security Group ID"
  value = try(
    aws_security_group.good[0].id,
    null
  )
}

output "bad_security_group_id" {
  description = "BAD Security Group ID"
  value = try(
    aws_security_group.bad[0].id,
    null
  )
}
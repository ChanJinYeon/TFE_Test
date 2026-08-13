#####################################################
# VPC - default
#####################################################
data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

#####################################################
# Security Group - default
#####################################################
data "aws_security_group" "default" {
  name   = "default"
  vpc_id = data.aws_vpc.default.id
}

#####################################################
# EC2
#####################################################
data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

locals {
  common_tags = {
    CreatedBy = var.created_by
    Project   = var.project
    Purpose   = var.purpose
    ManagedBy = "Terraform"
  }
}

resource "aws_instance" "test" {
  count = var.instance_count

  ami           = data.aws_ami.amazon_linux_2023.id
  instance_type = var.instance_type

  subnet_id = sort(data.aws_subnets.default.ids)[0]

  vpc_security_group_ids = [
    data.aws_security_group.default.id
  ]

  associate_public_ip_address = false

  root_block_device {
    volume_type = "gp3"
    volume_size = 8
  }

  tags = merge(
    local.common_tags,
    {
      Name = "tfe-test-${count.index + 1}"
    }
  )

  volume_tags = merge(
    local.common_tags,
    {
      Name = "tfe-test-volume-${count.index + 1}"
    }
  )
}
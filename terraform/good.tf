#####################################################
# Security Group - Policy Test
#####################################################
resource "aws_security_group" "good" {
  count = var.enable_good_sg ? 1 : 0

  name        = "cw-tfe-poc-1"
  description = "cw-tfe-poc-1"
  vpc_id      = data.aws_vpc.default.id

  tags = merge(
    local.common_tags,
    {
      Name = "cw-tfe-poc-1"
    }
  )
}

resource "aws_vpc_security_group_ingress_rule" "good_ssh" {
  count = var.enable_good_sg ? 1 : 0

  security_group_id = aws_security_group.good[0].id

  description = "Allow SSH from private network"

  ip_protocol = "tcp"
  from_port   = 22
  to_port     = 22

  cidr_ipv4 = "10.0.0.0/8"
}


resource "aws_vpc_security_group_egress_rule" "good_egress" {
  count = var.enable_good_sg ? 1 : 0

  security_group_id = aws_security_group.good[0].id

  ip_protocol = "-1"
  cidr_ipv4   = "0.0.0.0/0"
}
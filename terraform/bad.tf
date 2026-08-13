#####################################################
# Security Group - Policy Test
#####################################################
resource "aws_security_group" "bad" {
  count = var.enable_bad_sg ? 1 : 0

  name        = "cw-tfe-poc-2"
  description = "cw-tfe-poc-2"
  vpc_id      = data.aws_vpc.default.id

  tags = merge(
    local.common_tags,
    {
      Name = "cw-tfe-poc-2"
    }
  )
}

resource "aws_vpc_security_group_ingress_rule" "bad_ssh" {
  count = var.enable_bad_sg ? 1 : 0

  security_group_id = aws_security_group.bad[0].id

  description = "SSH open to the Internet"

  ip_protocol = "tcp"
  from_port   = 22
  to_port     = 22

  cidr_ipv4 = "0.0.0.0/0"
}


resource "aws_vpc_security_group_egress_rule" "bad_egress" {
  count = var.enable_bad_sg ? 1 : 0

  security_group_id = aws_security_group.bad[0].id

  ip_protocol = "-1"
  cidr_ipv4   = "0.0.0.0/0"
}
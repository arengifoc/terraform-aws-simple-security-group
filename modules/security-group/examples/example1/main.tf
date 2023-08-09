module "security-group" {
  source = "../../"

  description = "Test security group"
  vpc_id      = "vpc-4b720c32"
  name        = "test-sg-001"

  rules = {
    egress_all = {
      cidr_blocks      = ["0.0.0.0/0"]
      description      = "Allow all outgoing traffic"
      from_port        = -0
      ipv6_cidr_blocks = ["::/0"]
      protocol         = -1
      to_port          = 0
      type             = "egress"
    }

    inress_ssh_from_private = {
      cidr_blocks = ["172.16.0.0/12", "192.168.0.0/16"]
      description = "Allow incoming SSH traffic from trusted networks"
      from_port   = 22
      protocol    = "TCP"
      to_port     = 22
    }

    inress_ping_from_private = {
      cidr_blocks = ["172.16.0.0/12", "192.168.0.0/16"]
      description = "Allow ICMP queries from trusted networks"
      from_port   = -1
      protocol    = "ICMP"
      to_port     = -1
    }
  }
}

output "id" {
  description = "Security Group ID"
  value       = module.security-group.id
}

output "name" {
  description = "Security Group name"
  value       = module.security-group.name
}

output "arn" {
  description = "Security Group ARN"
  value       = module.security-group.arn
}

# Security Group with different options

Configuration in this directory creates a Security Group with the following characteristics:

- Security Group named "test-sg" plus a random pet name as suffix
- A rule that allows all outgoing traffic
- A rule that allows incoming traffic for SSH service from two CIDRs
- A rule that allows all incoming ICMP packets (including PING requests) from two CIDRs

## Usage

```hcl
module "security_group" {
  # Replace 'master' with an appropriate and recent tag for this module
  source = "git@github.com:EDRInc/infrastructure-modules.git//modules/aws-security-group?ref=master"

  description = "Test security group"
  vpc_id      = "vpc-4b720c32"
  name        = "test-sg"

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

    ingress_ssh_from_private = {
      cidr_blocks = ["172.16.0.0/12", "192.168.0.0/16"]
      description = "Allow incoming SSH traffic from trusted networks"
      port        = 22
      protocol    = "TCP"
    }

    ingress_ping_from_private = {
      cidr_blocks = ["172.16.0.0/12", "192.168.0.0/16"]
      description = "Allow ICMP queries from trusted networks"
      from_port   = -1
      protocol    = "ICMP"
      to_port     = -1
    }
  }
}
```

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.

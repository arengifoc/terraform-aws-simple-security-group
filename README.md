# Security Group module

This module creates Security Groups and rules in a simple way.

## Examples

| Name                             | Description                         |
| -------------------------------- | ----------------------------------- |
| [complete](./examples/complete/) | Security Group with different rules |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.4 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.0.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.5 |

## Resources

| Name | Type |
|------|------|
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [random_id.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | Security Group description | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name for the Security Group | `string` | n/a | yes |
| <a name="input_random_byte_length"></a> [random\_byte\_length](#input\_random\_byte\_length) | The number of random bytes to produce. The minimum value is 1, which produces eight bits of randomness. | `number` | `4` | no |
| <a name="input_rules"></a> [rules](#input\_rules) | Map of Security Group rules | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for the resources | `map(string)` | `{}` | no |
| <a name="input_use_random_name_suffix"></a> [use\_random\_name\_suffix](#input\_use\_random\_name\_suffix) | Whether to use a random name suffix for Security Groups | `bool` | `true` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | Security Group ARN |
| <a name="output_id"></a> [id](#output\_id) | Security Group ID |
| <a name="output_name"></a> [name](#output\_name) | Security Group name |
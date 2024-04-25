variable "description" {
  description = "Security Group description"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "rules" {
  description = "Map of Security Group rules"
  type        = any # In fact, it's an object with attributes described below

  # --------------------------------
  # Descriptions
  # --------------------------------
  # type                     : (Optional) Type of rule. Either ingress or egress. Defaults to
  #                            ingress.
  #
  # port                     : (Optional) Port number. If defined, overrides both from_port and
  #                            to_port.
  #
  # from_port                : (Optional) Start port number
  #
  # to_port                  : (Optional) End port number
  #
  # protocol                 : (Optional) Protocol. Defaults to TCP. Use -1 for all protocols
  #
  # description              : (Optional) Description of the rule
  #
  # prefix_list_ids          : (Optional) List of one of more prefix list IDs. Defaults to null.
  #
  # cidr_blocks              : (Optional: 1st priority) List of CIDR blocks. Can coexist with
  #                            ipv6_cidr_blocks. Defaults to null.
  #
  # ipv6_cidr_blocks         : (Optional: 1st priority) List of CIDR blocks. Can coexist with
  #                            cidr_blocks. Defaults to null.
  #
  # source_security_group_id : (Optional: 2nd priority) Source security group ID. Only used with
  #                            cidr_blocks and ipv6_cidr_blocks are empty. Defaults to null.
}

variable "name" {
  description = "Name for the Security Group"
  type        = string
}

variable "use_random_name_suffix" {
  description = "Whether to use a random name suffix for Security Groups"
  type        = bool
  default     = true
}

variable "random_byte_length" {
  description = "The number of random bytes to produce. The minimum value is 1, which produces eight bits of randomness."
  type        = number
  default     = 4
}

variable "tags" {
  description = "Tags for the resources"
  type        = map(string)
  default     = {}
}

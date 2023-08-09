variable "description" {
  description = "Security Group description"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "rules" {
  description = "List of rules"
  type        = any
  default     = {}
  # Structure
  # type                     = optional(string, "ingress")
  # from_port                = optional(number, 0)
  # to_port                  = optional(number, 0)
  # protocol                 = optional(string, "TCP")
  # description              = optional(string, "")
  # prefix_list_ids          = optional(list(string), [])
  # cidr_blocks              = optional(list(string), []) # 1st priority. Can coexist with ipv6_cidr_blocks
  # ipv6_cidr_blocks         = optional(list(string), []) # 1st priority. Can coexist with cidr_blocks
  # source_security_group_id = optional(string, null)     # 2nd priority. Only used with cidr_blocks and ipv6_cidr_blocks are empty
}

variable "tags" {
  description = "Tags for the resources"
  type        = map(string)
  default     = {}
}

variable "name" {
  description = "Name for the Security Group"
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "Name prefix for the Security Group"
  type        = string
  default     = null
}

variable "name_suffix_length" {
  type    = number
  default = 12
}

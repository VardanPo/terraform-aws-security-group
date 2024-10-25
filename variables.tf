# ------------------------------ Security group ------------------------------
variable "create_sg" {
  description = "Whether to create security group."
  type        = bool
  default     = true
}

variable "use_name_prefix" {
  description = "Whether to use name_prefix or fixed name. Should be true to able to update security group name after initial creation."
  type        = bool
  default     = false
}

variable "name" {
  description = "Name of security group - not required if create_sg is false."
  type        = string
  default     = null
}

variable "description" {
  description = "Description of security group (forces new resource)."
  type        = string
  default     = "Security Group managed by Terraform"
}

variable "vpc_id" {
  description = "VPC ID. Defaults to the region's default VPC (forces new resource)."
  type        = string
  default     = null
}

variable "revoke_rules_on_delete" {
  description = "Instruct Terraform to revoke all of the Security Groups attached ingress and egress rules before deleting the rule itself. Enable for EMR."
  type        = bool
  default     = false
}

variable "tags" {
  description = "A mapping of tags to assign to security group."
  type        = map(string)
  default     = {}
}

variable "create_timeout" {
  description = "Time to wait for a security group to be created."
  type        = string
  default     = "10m"
}

variable "delete_timeout" {
  description = "Time to wait for a security group to be deleted."
  type        = string
  default     = "15m"
}

# ------------------------------ Rules ------------------------------
variable "ingress_rules" {
  description = "List of ingress rules to create."
  # ingress_cidr_blocks - List of IPv4 CIDR ranges to use on all ingress rules.
  # ipv6_cidr_blocks - List of IPv6 CIDR ranges to use on all ingress rules.
  # prefix_list_ids - List of prefix list IDs (for allowing access to VPC endpoints) to use on all ingress rules.
  type = map(any)
  default = {
    "allow-all" = {
      description = "All protocols"
      cidr_blocks = ["0.0.0.0/0"]
      from_port   = -1
      to_port     = -1
      protocol    = "-1"
    }
  }
}

variable "security_group_id" {
  description = "Security group to apply this rule to."
  type        = string
  default     = null
}

variable "egress_rules" {
  description = "List of ingress rules to create."
  # ingress_cidr_blocks - List of IPv4 CIDR ranges to use on all ingress rules.
  # ipv6_cidr_blocks - List of IPv6 CIDR ranges to use on all ingress rules.
  # prefix_list_ids - List of prefix list IDs (for allowing access to VPC endpoints) to use on all ingress rules.
  type = map(any)
  default = {
    "allow-all" = {
      description = "All protocols"
      cidr_blocks = ["0.0.0.0/0"]
      from_port   = -1
      to_port     = -1
      protocol    = "-1"
    }
  }
}

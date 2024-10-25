# ------------------------------ Security group ------------------------------
output "arn" {
  description = "The ARN of the security group"
  value       = try(aws_security_group.example[0].arn, aws_security_group.prefix_example[0].arn, "")
}

output "id" {
  description = "The ID of the security group"
  value       = try(aws_security_group.example[0].id, aws_security_group.prefix_example[0].id, "")
}

output "vpc_id" {
  description = "The VPC ID"
  value       = try(aws_security_group.example[0].vpc_id, aws_security_group.prefix_example[0].vpc_id, "")
}

output "owner_id" {
  description = "The owner ID"
  value       = try(aws_security_group.example[0].owner_id, aws_security_group.prefix_example[0].owner_id, "")
}

output "name" {
  description = "The name of the security group"
  value       = try(aws_security_group.example[0].name, aws_security_group.prefix_example[0].name, "")
}

output "description" {
  description = "The description of the security group"
  value       = try(aws_security_group.example[0].description, aws_security_group.prefix_example[0].description, "")
}

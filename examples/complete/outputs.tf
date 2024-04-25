output "id" {
  description = "Security Group ID"
  value       = module.security_group.id
}

output "name" {
  description = "Security Group name"
  value       = module.security_group.name
}

output "arn" {
  description = "Security Group ARN"
  value       = module.security_group.arn
}

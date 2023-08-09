output "id" {
  description = "Security Group ID"
  value       = aws_security_group.this.id
}

output "name" {
  description = "Security Group name"
  value       = aws_security_group.this.name
}

output "arn" {
  description = "Security Group ARN"
  value       = aws_security_group.this.arn
}

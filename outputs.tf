output "namespace_id" {
  value = aws_service_discovery_private_dns_namespace.this.id
}

output "namespace_arn" {
  value = aws_service_discovery_private_dns_namespace.this.arn
}

output "service_ids" {
  value = try(zipmap(values(aws_service_discovery_service.this)[*]["name"], values(aws_service_discovery_service.this)[*]["id"]), {})
}

output "service_arns" {
  value = try(zipmap(values(aws_service_discovery_service.this)[*]["name"], values(aws_service_discovery_service.this)[*]["arn"]), {})
}

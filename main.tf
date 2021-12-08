locals {
  namespace_description = length(var.namespace_description) > 0 ? var.namespace_description : var.namespace
}

resource "aws_service_discovery_private_dns_namespace" "this" {
  name        = var.namespace
  description = local.namespace_description
  vpc         = var.vpc_id

  tags = var.tags
}

resource "aws_service_discovery_service" "this" {
  #for_each = { for service in var.services : service.name => service }
  for_each = var.services


  name = each.key


  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.this.id

    dynamic "dns_records" {
      for_each = lookup(each.value, "dns_records", [])
      content {
        ttl  = dns_records.value["ttl"]
        type = dns_records.value["type"]
      }
    }

    routing_policy = each.value.routing_policy
  }

  dynamic "health_check_config" {
    for_each = lookup(each.value, "health_check_config", [])
    content {
      failure_threshold = health_check_config.value["failure_threshold"]
      resource_path     = health_check_config.value["resource_path"]
      type              = health_check_config.value["type"]
    }
  }

  dynamic "health_check_custom_config" {
    for_each = lookup(each.value, "health_check_custom_config", [])
    content {
      failure_threshold = health_check_custom_config.value["failure_threshold"]
    }
  }

  tags = var.tags
}


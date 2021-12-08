variable "tags" {
  type    = map(any)
  default = {}
}

variable "vpc_id" {
  type = string
  default = ""
}

variable "services" {
  type = map(object({
    dns_records = list(object({
      ttl  = number
      type = string
    }))
    health_check_config = list(object({
      failure_threshold = number
      resource_path     = string
      type = string 
    }))
    health_check_custom_config = list(object({
      failure_threshold = number
    }))
    routing_policy = string
  }))

  default = {}
}

variable "namespace" {}

variable "namespace_description" {
  default = ""
}

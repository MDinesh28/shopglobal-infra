```
variable "project_name" {
  description = "Project name for resource tagging"
  type        = string
}

variable "region" {
  description = "AWS region for resources"
  type        = string
}

variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}
```
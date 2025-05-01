```
variable "project_name" {
  description = "Project name for resource tagging"
  type        = string
  default     = "shopglobal"
}

variable "cidr_blocks" {
  description = "CIDR blocks for VPCs"
  type        = map(string)
  default = {
    us_east_1 = "10.0.0.0/16"
    eu_west_1 = "10.1.0.0/16"
  }
}
```
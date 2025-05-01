```
output "us_east_1_vpc_id" {
  value = module.us_east_1_infra.vpc_id
}

output "eu_west_1_vpc_id" {
  value = module.eu_west_1_infra.vpc_id
}

output "us_east_1_rds_endpoint" {
  value = module.us_east_1_infra.rds_endpoint
}

output "eu_west_1_rds_endpoint" {
  value = module.eu_west_1_infra.rds_endpoint
}

output "us_east_1_app_instance_ids" {
  value = module.us_east_1_infra.app_instance_ids
}

output "eu_west_1_app_instance_ids" {
  value = module.eu_west_1_infra.app_instance_ids
}
```
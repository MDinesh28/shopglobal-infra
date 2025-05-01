```
output "vpc_id" {
  value = aws_vpc.main.id
}

output "rds_endpoint" {
  value = aws_db_instance.main.endpoint
}

output "app_instance_ids" {
  value = aws_instance.app[*].id
}
```
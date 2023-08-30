output "subnet_public_id" {
  value = aws_subnet.subnet_public.id
}
output "subnet_private_id" {
  value = aws_subnet.subnet_private.id
}

output "security_group_public_id" {
  value = aws_security_group.security_group_public.id
}
output "security_group_private_id" {
  value = aws_security_group.security_group_public.id
}

output "public_ip" {
  value       = azurerm_public_ip.public_ip.ip_address
  description = "The public IP address of the deployed server."
}
output "ssh_public_key" {
  value       = tls_private_key.deploy_key.public_key_openssh
  description = "Generated SSH public key (openssh format) used for VM access."
}

output "private_key_path" {
  value       = "${path.module}/ssh_private_key.pem"
  description = "Path to the generated private key file on the machine that ran Terraform."
}
output "admin_username" {
  value       = var.admin_username
  description = "Admin username for the VM."
}
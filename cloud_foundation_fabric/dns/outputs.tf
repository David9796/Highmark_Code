
output "name" {
  description = "The DNS zone name."
  value       = try(local.zone.name, null)
}

output "domain" {
  description = "The DNS zone domain."
  value       = try(local.zone.dns_name, null)
}
output "visibility" {
  value = var.visibility
}

output "client_networks" {
  value = var.client_networks
}

output "peer_network" {
  value = var.peer_network
}

output "type" {
  value = var.type
}

output "forwarders" {
  value = var.forwarders
}


output "name_servers" {
  description = "The DNS zone name servers."
  value       = try(local.zone.name_servers, null)
}

output "dns_keys" {
  description = "DNSKEY and DS records of DNSSEC-signed managed zones."
  value       = local.dns_keys
}

output "zone" {
  description = "DNS zone resource."
  value       = local.zone
}
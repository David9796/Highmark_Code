/*
 Copyright 2021 Accenture LLP
 */

output "network_name" {
  value = module.git_euw4_vpc.network_name
}

output "subnets_list" {
  value = [for network in module.git_euw4_vpc.subnets : network.name]
}

output "subnets_git_gen_01_euw4_p_net" {
  value = [for network in module.git_euw4_vpc.subnets : network.name][0]
}
output "subnets_ips" {
  value = module.git_euw4_vpc.subnets_ips
}

output "network_self_link" {
  value = module.git_euw4_vpc.network_self_link

}

output "subnets_self_links_subnets_git_gen_01_euw4_p_net" {
  value = [for network in module.git_euw4_vpc.subnets : network.self_link][0]
}

## peering
output "git_euw4_vpc_to_nwhub_euw4_vpc_peer" {
  value = google_compute_network_peering.peering_git_nwhub.name
}

## firewall
output "firewall_names_e_giteuw4_vpc_to_external_allow" {
  value = [for network in module.git_euw4_vpc.firewall_names : network.name][0]
}
output "firewall_names_i_giteuw4_saprule2_allow" {
  value = [for network in module.git_euw4_vpc.firewall_names : network.name][1]
}


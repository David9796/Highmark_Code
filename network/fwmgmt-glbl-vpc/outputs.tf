/*
 Copyright 2021 Accenture LLP
 */

output "network_name" {
  value = module.fwmgmt_glbl_vpc.network_name
}

output "network_self_link" {
  value = module.fwmgmt_glbl_vpc.network_self_link

}

output "subnets_mgmt_fw_01_use4_p_net" {
  value = [for network in module.fwmgmt_glbl_vpc.subnets : network.name][1]

}

output "subnets_mgmt_fw_01_sae1_p_net" {
  value = [for network in module.fwmgmt_glbl_vpc.subnets : network.name][0]

}


output "subnets_ips" {
  value = module.fwmgmt_glbl_vpc.subnets_ips

}

output "subnets_self_links_subnets_mgmt_fw_01_use4_p_net" {
  value = [for network in module.fwmgmt_glbl_vpc.subnets : network.self_link][1]
}

output "subnets_self_links_subnets_mgmt_fw_01_sae1_p_net" {
  value = [for network in module.fwmgmt_glbl_vpc.subnets : network.self_link][0]
}


## routes
output "route_fwmgmt_glbl_igw_default_rt_01" {
  value = [for route in module.fwmgmt_glbl_vpc.routes : route.name][0]

}

## firewall
output "firewall_names_e_fwmgmtglbl_vpc_to_external_allow" {
  value = [for network in module.fwmgmt_glbl_vpc.firewall_names : network.name][0]
}

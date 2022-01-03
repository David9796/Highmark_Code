/*
 Copyright 2021 Accenture LLP
 */

locals {
  p_glbl_h_hub_gitrnd_project_id = data.terraform_remote_state.project.outputs.p_glbl_h_hub_gitrnd_project_id
  vpc_host_network_name          = "fwmgmt-glbl-vpc"
  mgmt_fw_01_use4_p_net          = "mgmt-fw-01-use4-p-net"
  mgmt_fw_01_sae1_p_net          = "mgmt-fw-01-sae1-p-net"

}


#####################################################################################################
# Creation of VPC in Project p-glbl-host-nwhub-gitrnd. This VPC serves as  VPC for FWMGMT-GLBL  #
#####################################################################################################

module "fwmgmt_glbl_vpc" {
  source                                 = "../../modules/accenture/network"
  project_id                             = local.p_glbl_h_hub_gitrnd_project_id
  network_name                           = local.vpc_host_network_name
  routing_mode                           = "REGIONAL"
  delete_default_internet_gateway_routes = "true"
  description                            = "Temporary VPC for firewal management"

  //optional when you have to enable the shared vpc for project
  #shared_vpc_host = "true"

  ##############################################################
  ##  Creation of Subnets in VPC (EXTERNAL-GLBL for NORTH VIRGINIA Region)   #
  ##############################################################

  subnets = [
    {
      subnet_name           = local.mgmt_fw_01_use4_p_net
      subnet_ip             = "10.140.1.192/26"
      subnet_region         = "us-east4"
      subnet_private_access = "true"
      subnet_flow_logs      = "true"
      description           = "Subnet for Network management at North Virginia"
    },
    {
      subnet_name           = local.mgmt_fw_01_sae1_p_net
      subnet_ip             = "10.129.1.192/26"
      subnet_region         = "southamerica-east1"
      subnet_private_access = "true"
      subnet_flow_logs      = "true"
      description           = "Subnet for Network management at Sao Paulo"
    },

  ]

  routes = [
    {
      name              = "fwmgmt-glbl-igw-default-rt-01"
      description       = "Default internet gateway for ngfws"
      destination_range = "0.0.0.0/0"
      next_hop_internet = "true"
      priority          = 1000
    }
  ]

  ####################################################################################################
  ##  Creation of Firewall in VPC (FWMGMT-GLBL for NORTH VIRGINIA,SAO PAULO,NETHERLANDS Region)   ##
  ####################################################################################################

  firewall_rules = [
    {
      name                    = "e-fwmgmtglbl-vpc-to-external-allow"
      direction               = "EGRESS"
      priority                = 1100
      ranges                  = ["0.0.0.0/0"]
      source_tags             = null
      source_service_accounts = null
      target_tags             = ["checkpoint-management"]
      target_service_accounts = null
      allow = [{
        protocol = "all"
        ports    = []
      }]
      deny       = []
      log_config = null
    }
    
  ]

}

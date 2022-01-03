/*
 Copyright 2021 Accenture LLP
 */

locals {
  p_euw4_h_git_project_id       = data.terraform_remote_state.project_shared.outputs.p_euw4_h_git_project_id
  p_euw4_s_git_apps_project_id  = data.terraform_remote_state.project_git.outputs.p_euw4_s_git_apps_project_id
  terraform_service_account     = data.terraform_remote_state.company.outputs.terraform_service_account
  git_gen_01_euw4_p_net         = "git-gen-01-euw4-p-net"

  vpc_host_network_name         = "git-euw4-vpc"

  ## For peering
  vpc_host_peer_network_name     = data.terraform_remote_state.peer_network.outputs.network_name
  p_glbl_h_hub_gitrnd_project_id = data.terraform_remote_state.project_shared.outputs.p_glbl_h_hub_gitrnd_project_id

}
#####################################################################################################
# Shared VPC for GIT at Netherlands                                                                 #
#####################################################################################################

module "git_euw4_vpc" {
  source = "../../modules/accenture/network"

  project_id                             = local.p_euw4_h_git_project_id
  network_name                           = local.vpc_host_network_name
  routing_mode                           = "REGIONAL"
  delete_default_internet_gateway_routes = "true"
  description                            = "Shared VPC for GIT at Netherlands"

  //optional when you have to enable the shared vpc for project
  shared_vpc_host = "true"

  ##################################################################
  ##  Creation of Subnets in VPC (for Netherlands Region)#
  ##################################################################


  subnets = [
    {
      subnet_name           = local.git_gen_01_euw4_p_net
      subnet_ip             = "10.132.16.0/23"
      subnet_region         = "europe-west4"
      subnet_private_access = "true"
      subnet_flow_logs      = "true"
      description           = "Subnet for GIT prod applications at Netherlands"
    }

  ]

  ####################################################################################################
  ##  Creation of Firewall in VPC (for Netherlands Region)   ##
  ####################################################################################################

  firewall_rules = [
    {
      name                    = "e-giteuw4-vpc-to-external-allow"
      direction               = "EGRESS"
      priority                = 10000
      ranges                  = ["0.0.0.0/0"]
      source_tags             = null
      source_service_accounts = null
      target_tags             = null
      target_service_accounts = null
      allow = [{
        protocol = "all"
        ports    = []
      }]
      deny       = []
      log_config = null
    },
    
    {
      name                    = "i-giteuw4-saprule2-allow"
      direction               = "INGRESS"
      priority                = 2200
      ranges                  = null
      source_tags             = ["euw4-mxf-sap-app"]
      source_service_accounts = null
      target_tags             = ["euw4-ahk-sap-app"]
      target_service_accounts = null
      allow = [{
        protocol = "tcp"
        ports    = ["8000-8199", "3300-3399", "3600-3699", "2049-2055", "111", "50000", "50100"]
        },
        {
          protocol = "udp"
          ports    = ["2049-2055", "111"]
      }]
      deny       = []
      log_config = null
    }

  ]

}


########################################################################################
# Creation of VPC Peering from DMZ_GIT_RND VPC to Network Interconnect VPC                     #
########################################################################################

resource "google_compute_network_peering" "peering_git_nwhub" {
  name                 = "git-euw4-vpc-to-nwhub-euw4-vpc-peer"
  network              = "projects/${local.p_euw4_h_git_project_id}/global/networks/${local.vpc_host_network_name}"
  peer_network         = "projects/${local.p_glbl_h_hub_gitrnd_project_id}/global/networks/${local.vpc_host_peer_network_name}"
  import_custom_routes = true
}


resource "time_sleep" "wait_30_seconds" {
  depends_on      = [module.git_euw4_vpc.network_self_link]
  create_duration = "30s"
}
########################################################################################
# Creation of Subnet Iam Binding                    #
########################################################################################

module "p_euw4_h_git_p_euw4_s_git_apps" {
  source              = "../../modules/accenture/network/modules/fabric-net-svpc-access"
  host_project_id     = local.p_euw4_h_git_project_id
  service_project_num = 1
  service_project_ids = [local.p_euw4_s_git_apps_project_id]
  host_subnets        = [local.git_gen_01_euw4_p_net]
  host_subnet_regions = ["europe-west4"]
  host_subnet_users = {
    git-gen-01-euw4-p-net = "serviceAccount:${local.terraform_service_account}"
  }
  depends_on = [time_sleep.wait_30_seconds]
}


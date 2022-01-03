variable "data_block_bucket" {
  description = "data block bucket variable"
  type        = string
  default     = ""
}

variable "project_prefix" {
  description = "data block project prefix variable"
  type        = string
  default     = ""
}

variable "enable_shared_vpc_service_project" {
  description = "Flag set if SVPC enabled"
  type        = bool
  default     = false
}

variable "host_project_id" {
  description = " host_project_id "
  default     = " "
}

variable "service_project_id" {
  description = " service_project_id "
  default     = " "
}


variable "billing_account" {
  description = " billing_account "
  default     = ""
}


variable "project_id" {
  description = "The ID of the project where this VPC will be created"
  default     = ""
}

variable "vpc_host_network_name" {
  description = "The Name of the network to create"
  type        = string
  default     = ""

}

variable "routing_mode" {
  type        = string
  default     = "GLOBAL"
  description = "The network routing mode (default 'GLOBAL')"
}

variable "shared_vpc_host" {
  type        = bool
  description = "Makes this project a Shared VPC host if 'true' (default 'false')"
  default     = false
}

variable "subnets" {
  type        = list(map(string))
  description = "The list of subnets being created"
  default     = []
}

variable "secondary_ranges" {
  type        = map(list(object({ range_name = string, ip_cidr_range = string })))
  description = "Secondary ranges that will be used in some of the subnets"
  default     = {}
}

variable "routes" {
  type        = list(map(string))
  description = "List of routes being created in this VPC"
  default     = []
}

variable "firewall_rules" {
  type        = any
  description = "List of firewall rules"
  default     = []
}

variable "delete_default_internet_gateway_routes" {
  type        = bool
  description = "If set, ensure that all routes within the network specified whose names begin with 'default-route' and with a next hop of 'default-internet-gateway' are deleted"
  default     = false
}

variable "description" {
  type        = string
  description = "An optional description of this resource. The resource must be recreated to modify this field."
  default     = ""
}

variable "auto_create_subnetworks" {
  type        = bool
  description = "When set to true, the network is created in 'auto subnet mode' and it will create a subnet for each region automatically across the 10.128.0.0/9 address range. When set to false, the network is created in 'custom subnet mode' so the user can explicitly connect subnetwork resources."
  default     = false
}

variable "mtu" {
  type        = number
  description = "The network MTU. Must be a value between 1460 and 1500 inclusive. If set to 0 (meaning MTU is unset), the network will default to 1460 automatically."
  default     = 0
}

########### added below variables for network peering ########################33

# variable "local_project_id" {
#   description = "project id for local peering network"
#   type        = string
# }

# variable "peer_project_id" {
#   description = "project id for peer peering network"
#   type        = string
# }

# variable "name_prefix" {
#   description = "A name prefix used in resource names to ensure uniqueness across a project."
#   type        = string
#   default     = "to"
# }

# variable "prefix" {
#   description = "Name prefix for the network peerings"
#   type        = string
#   default     = ""
# }

# variable "peer_name" {
#   description = "peer peering name."
#   type        = string
# }

# variable "local_name" {
#   description = "local peering name."
#   type        = string
# }

# variable "local_network" {
#   description = "Resource link of the network to add a peering to."
#   type        = string
# }

# variable "peer_network" {
#   description = "Resource link of the peer network."
#   type        = string
# }

variable "export_peer_custom_routes" {
  description = "Export custom routes to local network from peer network."
  type        = bool
  default     = false
}

variable "export_local_custom_routes" {
  description = "Export custom routes to peer network from local network."
  type        = bool
  default     = false
}

variable "export_peer_subnet_routes_with_public_ip" {
  description = "Export custom routes to local network from peer network (defaults to false; causes the Local Peering Connection to align with the [provider default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network_peering#import_subnet_routes_with_public_ip), and the Remote Peering Connection to be opposite the provider default)."
  type        = bool
  default     = false
}

variable "export_local_subnet_routes_with_public_ip" {
  description = "Export custom routes to peer network from local network (defaults to true; causes the Local Peering Connection to align with the [provider default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network_peering#export_subnet_routes_with_public_ip), and the Remote Peering Connection to be opposite the provider default)."
  type        = bool
  default     = false
}

variable "module_depends_on" {
  description = "List of modules or resources this module depends on."
  type        = list(any)
  default     = []
}

##########################################################
#  VPN Variables 
#######################################################

variable "peer_external_gateway" {
  description = "Configuration of an external VPN gateway to which this VPN is connected."
  type = object({
    name            = string
    redundancy_type = string
    interfaces = list(object({
      id         = number
      ip_address = string
    }))
  })
  default = null
}

variable "peer_gcp_gateway" {
  description = "Self Link URL of the peer side HA GCP VPN gateway to which this VPN tunnel is connected."
  type        = string
  default     = null
}

# variable "name" {
#   description = "VPN gateway name, and prefix used for dependent resources."
#   type        = string
# }

# variable "network" {
#   description = "VPC used for the gateway and routes."
#   type        = string
# }

# variable "project_id" {
#   description = "Project where resources will be created."
#   type        = string
# }

variable "region" {
  description = "Region used for resources."
  type        = string
  default     = ""
}

variable "route_priority" {
  description = "Route priority, defaults to 1000."
  type        = number
  default     = 1000
}

variable "router_advertise_config" {
  description = "Router custom advertisement configuration, ip_ranges is a map of address ranges and descriptions."
  type = object({
    groups    = list(string)
    ip_ranges = map(string)
    mode      = string
  })
  default = null
}

variable "router_asn" {
  description = "Router ASN used for auto-created router."
  type        = number
  default     = 64514
}

variable "router_name" {
  description = "Name of router, leave blank to create one."
  type        = string
  default     = ""
}

variable "tunnels" {
  description = "VPN tunnel configurations, bgp_peer_options is usually null."
  type = map(object({
    bgp_peer = object({
      address = string
      asn     = number
    })
    bgp_peer_options = object({
      advertise_groups    = list(string)
      advertise_ip_ranges = map(string)
      advertise_mode      = string
      route_priority      = number
    })
    bgp_session_range               = string
    ike_version                     = number
    vpn_gateway_interface           = number
    peer_external_gateway_interface = number
    shared_secret                   = string
  }))
  default = {}
}

variable "vpn_gateway_self_link" {
  description = "self_link of existing VPN gateway to be used for the vpn tunnel"
  default     = null
}

variable "create_vpn_gateway" {
  description = "create a VPN gateway"
  default     = true
  type        = bool
}
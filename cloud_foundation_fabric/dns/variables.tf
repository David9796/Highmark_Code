variable "project_id" {
  description = "Project id where the zone will be created"
  type        = string
  default     = ""
}
variable "client_networks" {
  description = "Source network"
  type        = list(string)
  default     = []
}
variable "peer_network" {
  description = "Peer network"
  type        = string
  default     = ""
}
variable "name" {
  description = "DNS zone name"
  type        = string
  default     = ""
}
variable "domain" {
  description = "Zone domain"
  type        = string
  default     = ""
}
variable "description" {
  description = "zone description (shown in console)"
  type        = string
  default     = ""
}
variable "visibility" {
  description = "peering"
  type        = string
  default     = ""
}
variable "type" {
  description = "Type of zone to create, valid values are 'public', 'private', 'forwarding', 'peering', 'service-directory'."
  type        = string
  default     = ""
  /*
  validation {
    condition     = contains(["public", "private", "forwarding", "peering", "service-directory"], var.type)
    error_message = "Zone must be one of 'public', 'private', 'forwarding', 'peering', 'service-directory'."
  }
*/
}
variable "forwarders" {
  description = "Map of {IPV4_ADDRESS => FORWARDING_PATH} for 'forwarding' zone types. Path can be 'default', 'private', or null for provider default."
  type        = map(string)
  default     = {}
}
variable "zone_create" {
  description = "Create zone. When set to false, uses a data source to reference existing zone."
  type        = bool
  default     = true
}
variable "recordsets" {
  type = list(object({
    name    = string
    type    = string
    ttl     = number
    records = list(string)
  }))
  description = "List of DNS record objects to manage."
  default     = []
}
variable "service_directory_namespace" {
  description = "Service directory namespace id (URL), only valid for 'service-directory' zone types."
  type        = string
  default     = null
}

variable "default_key_specs_key" {
  description = "DNSSEC default key signing specifications: algorithm, key_length, key_type, kind."
  type        = any
  default     = {}
}
variable "default_key_specs_zone" {
  description = "DNSSEC default zone signing specifications: algorithm, key_length, key_type, kind."
  type        = any
  default     = {}
}
variable "dnssec_config" {
  description = "DNSSEC configuration: kind, non_existence, state."
  type        = any
  default     = {}
}
variable "project_prefix" {
  description = "data block project prefix variable"
  type        = string
  default     = ""
}
variable "data_block_bucket" {
  description = "data block bucket variable"
  type        = string
  default     = ""
}
variable "network_gitdmz_euw4_vpc_prefix" {
  description = "data block network prefix variable"
  type        = string
  default     = ""
}
variable "network_rnd_euw4_vpc_prefix" {
  description = "data block network prefix variable"
  type        = string
  default     = ""
}

variable "network_rnddmz_euw4_vpc_prefix" {
  description = "data block network prefix variable"
  type        = string
  default     = ""
}
variable "network_cmndmz_euw4_vpc_prefix" {
  description = "data block network prefix variable"
  type        = string
  default     = ""
}
variable "network_git_sae1_vpc_prefix" {
  description = "data block network prefix variable"
  type        = string
  default     = ""
}
variable "network_gitrnd_sae1_vpc_prefix" {
  description = "data block network prefix variable"
  type        = string
  default     = ""
}
variable "network_rnd_sae1_vpc_prefix" {
  description = "data block network prefix variable"
  type        = string
  default     = ""
}
variable "network_rnddmz_sae1_vpc_prefix" {
  description = "data block network prefix variable"
  type        = string
  default     = ""
}
variable "network_cmndmz_sae1_vpc_prefix" {
  description = "data block network prefix variable"
  type        = string
  default     = ""
}
variable "network_cmn_use4_vpc_prefix" {
  description = "data block network prefix variable"
  type        = string
  default     = ""
}

variable "network_cmn_euw4_vpc_prefix" {
  description = "data block network prefix variable"
  type        = string
  default     = ""
}
variable "network_gitrndcdns_glbl_vpc_prefix" {
  description = "data block network prefix variable"
  type        = string
  default     = ""
}
variable "network_cmn_sae1_vpc_prefix" {
  description = "data block network prefix variable"
  type        = string
  default     = ""
}
variable "network_git_use4_vpc_prefix" {
  description = "data block network prefix variable"
  type        = string
  default     = ""
}
variable "network_gitdmz_use4_vpc_prefix" {
  description = "data block network prefix variable"
  type        = string
  default     = ""
}
variable "network_rnd_use4_vpc_prefix" {
  description = "data block network prefix variable"
  type        = string
  default     = ""
}
variable "network_rnddmz_use4_vpc_prefix" {
  description = "data block network prefix variable"
  type        = string
  default     = ""
}

variable "network_cmndmz_use4_vpc_prefix" {
  description = "data block network prefix variable"
  type        = string
  default     = ""
}
variable "network_git_euw4_vpc_prefix" {
  description = "data block network prefix variable"
  type        = string
  default     = ""
}
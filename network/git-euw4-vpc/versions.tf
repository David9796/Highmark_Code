/**
 * Copyright 2021 Accenture LLP
 */
/*
terraform {
  required_version = ">= 0.13"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 3.43, <4.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 3.43, <4.0"
    }
  }
  provider_meta "google" {
    module_name = "blueprints/terraform/terraform-google-project-factory:shared_vpc_access/v10.3.0"
  }
  provider_meta "google-beta" {
    module_name = "blueprints/terraform/terraform-google-project-factory:shared_vpc_access/v10.3.0"
  }
}

terraform {
  required_version = ">= 0.13.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "<4.0,>= 2.12"
    }
  }

}

*/

terraform {
  required_version = ">= 0.13"

  required_providers {
    google = ">= 3.57"

  }
}
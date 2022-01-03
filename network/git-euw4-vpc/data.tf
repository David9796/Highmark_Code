data "terraform_remote_state" "project_shared" {
  backend = "gcs"
  config = {
    bucket = var.data_block_bucket
    prefix = var.project_shared_prefix
  }
}
data "terraform_remote_state" "project_git" {
  backend = "gcs"
  config = {
    bucket = var.data_block_bucket
    prefix = var.project_git_prefix
  }
}
data "terraform_remote_state" "company" {
  backend = "gcs"
  config = {
    bucket = var.data_block_bucket
    prefix = var.company_prefix
  }
}

## For peering
data "terraform_remote_state" "peer_network" {
  backend = "gcs"
  config = {
    bucket = var.data_block_bucket
    prefix = var.peer_network_prefix
  }
}

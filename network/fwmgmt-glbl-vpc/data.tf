data "terraform_remote_state" "project" {
  backend = "gcs"
  config = {
    bucket = var.data_block_bucket
    prefix = var.project_prefix
  }
}
